//
//  CourseView.swift
//  design-n-code
//
//  Created by Igor Kim on 13.12.20.
//

import SwiftUI

struct CourseView: View {
    @Binding var show: Bool
    @Binding var active: Bool
    
    var index: Int
    @Binding var activeIndex: Int
    
    var course: Course
    
    var body: some View {
        ZStack(alignment: .top) {
            CourseTextView(show: show)
            
            CourseCardView(show: $show, active: $active, course: course, index: index, activeIndex: $activeIndex)
        }
        .frame(height: show ? screen.height : 280)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView(
            show: .constant(false), active: .constant(false),
            index: 0, activeIndex: .constant(0),
            course: courseData[0]
        )
    }
}

struct CourseTextView: View {
    var show: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30.0) {
            Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
            
            Text("About this course")
                .font(.title).bold()
            
            Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS.")
            
            Text("While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
        }
        .padding(30)
        .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
        .offset(y: show ? 460 : 0)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
        .opacity(show ? 1 : 0)
    }
}

struct CourseCardView: View {
    @Binding var show: Bool
    @Binding var active: Bool
    
    var course: Course
    
    var index : Int
    @Binding var activeIndex: Int
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(course.title)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Text(course.subtitle)
                        .foregroundColor(Color.white.opacity(0.7))
                }
                Spacer()
                ZStack {
                    Image(uiImage: course.logo)
                        .opacity(show ? 0 : 1)
                    
                    VStack {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(width: 36, height: 36)
                    .background(Color.black)
                    .clipShape(Circle())
                    .opacity(show ? 1 : 0)
                }
            }
            Spacer()
            Image(uiImage: course.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(height: 140, alignment: .top)
        }
        .padding(show ? 30 : 20)
        .padding(.top, show ? 30 : 0)
        .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
        .background(Color(course.color))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
        .onTapGesture {
            show.toggle()
            active.toggle()
            activeIndex = show ? index : -1
        }
    }
}
