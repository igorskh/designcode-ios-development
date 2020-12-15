//
//  CourseList.swift
//  design-n-code
//
//  Created by Igor Kim on 13.12.20.
//

import SwiftUI
import Introspect

struct CourseList: View {
    @State var courses = courseData
    @State var active = false
    @State var activeIndex = -1
    
    @State var activeView = CGSize.zero
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(Double(activeView.height/500))
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30.0) {
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    ForEach(courses.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            CourseDetail(
                                show: $courses[index].show,
                                active: $active,
                                index: index,
                                activeIndex: $activeIndex,
                                activeView: $activeView,
                                course: courses[index]
                            )
                            .offset(y: courses[index].show ? -geometry.frame(in: .global).minY : 0)
                            .opacity(activeIndex != index && active ? 0 : 1)
                            .scaleEffect(activeIndex != index && active ? 0.5 : 1)
                            .offset(x: activeIndex != index && active ? -screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: courses[index].show ? .infinity : screen.width - 60)
                        .zIndex(courses[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .introspectScrollView { scrollView in
                scrollView.isScrollEnabled = !active
            }
            .statusBar(hidden: false)
            .animation(.linear)
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: UIImage
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
   Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
   Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card3"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
   Course(title: "UI Design for Developers", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]
