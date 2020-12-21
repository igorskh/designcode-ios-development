//
//  CourseDetail.swift
//  design-n-code
//
//  Created by Igor Kim on 13.12.20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseDetail: View {
    @Binding var show: Bool
    @Binding var active: Bool
    
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    
    @State var textScrollOffset: (x: CGFloat, y: CGFloat) = (x: 0, y: 0)
    
    var course: Course
    
    var body: some View {
        ZStack(alignment: .top) {
            CourseTextView(show: show, textScrollOffset: $textScrollOffset)
            
            CourseCardView(show: $show,
                           active: $active,
                           course: course,
                           index: index,
                           activeIndex: $activeIndex,
                           activeView: $activeView)
                .frame(height: textScrollOffset.y < 0 ? 460 + textScrollOffset.y*2 : 460)
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - activeView.height / 1000)
        .hueRotation(Angle(degrees: Double(activeView.height)))
        .rotation3DEffect(Angle(degrees: Double(activeView.height / 10)), axis: (x: 0, y: 10, z: 0))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(
            show: .constant(true), active: .constant(true),
            index: 0, activeIndex: .constant(0),
            activeView: .constant(CGSize.zero),
            course: courseData[0]
        )
        .environment(\.colorScheme, .dark)
    }
}

struct CourseTextView: View {
    var show: Bool
    @Binding var textScrollOffset: (x: CGFloat, y: CGFloat)
    
    var body: some View {
        ScrollView(offsetChanged: {
            textScrollOffset.x = $0.x
            textScrollOffset.y = $0.y
        }) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                
                Text("About this course")
                    .font(.title).bold()
                
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS.")
                
                Text("While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                
                Text("While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
            }
            .padding(.bottom, 100)
            .padding(30)
        }
        .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
        .offset(y: show ? 460 + textScrollOffset.y*1.5 : 0)
        .padding(.bottom, show ? 460 + textScrollOffset.y*1.5 : 0)
        .background(Color("background1"))
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
    @Binding var activeView: CGSize
    
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
            WebImage(url: course.image)
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
        .gesture(
            DragGesture(minimumDistance: 60)
                .onChanged { value in
                    guard value.translation.height > 0 else { return }
                    guard value.translation.height < 300 else { return }
                    activeView = value.translation
                }
                .onEnded { value in
                    if activeView.height > 50 {
                        show = false
                        active = false
                        activeIndex = -1
                    }
                    activeView = .zero
                }
        )
        .onTapGesture {
            show.toggle()
            active.toggle()
            activeIndex = show ? index : -1
        }
    }
}
