//
//  NotificationService.swift
//  notification-service
//
//  Created by Igor Kim on 23.12.20.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    var originalContent: UNMutableNotificationContent!

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        originalContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            bestAttemptContent.subtitle = "\(bestAttemptContent.subtitle) [modified]"
            
            if let dataMessage = bestAttemptContent.userInfo["message"] as? String {
                bestAttemptContent.body = "\(bestAttemptContent.body) + \(dataMessage)"
            }
            
            guard let mediaUrl = bestAttemptContent.userInfo["mediaUrl"] as? String else {
                print("Bad mediaUrl in push payload!")
                contentHandler(self.originalContent)
                return
            }
            
            let imageUrl = URL(string: mediaUrl)
            let session = URLSession.shared
            
            let task = session.downloadTask(with: imageUrl!, completionHandler: { (url, response, error) in
                guard let url = url else {
                    contentHandler(self.originalContent)
                    return
                }
                
                do {
                    let attachmentID = "attach-" + ProcessInfo.processInfo.globallyUniqueString
                    let filePath = NSTemporaryDirectory() + "/" + attachmentID + ".png"
                    
                    try FileManager.default.moveItem(atPath: url.path, toPath: filePath)
                    let attachment = try UNNotificationAttachment(identifier: attachmentID, url: URL(fileURLWithPath: filePath))
                    
                    bestAttemptContent.attachments.append(attachment)
                }
                catch {
                    print("Download file error: \(String(describing: error))")
                    contentHandler(self.originalContent)
                    return
                }

                contentHandler(bestAttemptContent)
            })
            task.resume()
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
