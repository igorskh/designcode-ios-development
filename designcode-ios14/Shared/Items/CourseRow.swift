//
//  CourseRow.swift
//  designcode-ios14
//
//  Created by Igor Kim on 18.11.20.
//

import SwiftUI

struct CourseRow: View {
    var item: CourseSection = courseSections[0]
    
    var body: some View {
        HStack(alignment: .top) {
            Image(item.logo)
                .renderingMode(.original)
                .frame(width: 48.0, height: 48.0)
                .imageScale(.medium)
                .background(item.color)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(item.subtitle)
                    .font(.footnote)
                    .foregroundColor(Color.secondary)
            }
            Spacer()
        }
        .font(.subheadline)
        .font(.system(size: 34, weight: .light, design: .rounded))
    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        CourseRow()
    }
}
