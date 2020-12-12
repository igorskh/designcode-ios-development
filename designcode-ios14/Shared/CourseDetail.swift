//
//  CourseDetail.swift
//  designcode-ios14
//
//  Created by Igor Kim on 18.11.20.
//

import SwiftUI

struct CourseDetail: View {
    var course: Course = courses[0]
    var namespace: Namespace.ID
    
    #if os(iOS)
    var cornerRadius: CGFloat = 10
    #else
    var cornerRadius: CGFloat = 0
    #endif
    
    @State var showModal = false
    
    var body: some View {
        #if os(iOS)
        content
            .ignoresSafeArea(.all)
        #else
        content
        #endif
    }
    
    var content: some View {
        
        VStack {
            ScrollView {
                CourseItem(course: course, cornerRadius: 0)
                    .matchedGeometryEffect(id: course.id, in: namespace)
                    .frame(height: 300)
                VStack {
                    ForEach(courseSections) { item in
                        CourseRow(item: item)
                            .sheet(isPresented: $showModal) {
                                CourseSectionDetail()
                            }
                            .onTapGesture {
                                showModal = true
                            }
                        Divider()
                    }
                    .padding(10)
                }
            }
        }
        .background(Color("Background 1"))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .matchedGeometryEffect(id: "container-\(course.id)", in: namespace)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseDetail(namespace: namespace)
    }
}
