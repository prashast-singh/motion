//
//  HipView.swift
//  MotionAnalysis
//
//  Created by Prashast Singh on 04.11.24.
//

import SwiftUI
import Foundation

//
//  KneeView.swift
//  MotionAnalysis
//
//  Created by Prashast Singh on 04.11.24.
//

import SwiftUI
import Foundation

struct HipView : View {
    var body: some View {
        VStack(spacing: 20) {
            Text("LEFT HIP MOVEMENTS")
                .font(.system(size: 30, weight: .bold))
            
            NavigationLink(destination: StoryboardViewWrapper(joint: .hip , bodySide: .left, recordDirection: .side)) {
                Text("FLEXION EXTENSION")
                    .font(.system(size: 25, weight: .bold))
                    .frame(width: 300, height: 100)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            NavigationLink(destination: StoryboardViewWrapper(joint: .hip , bodySide: .left, recordDirection: .front)) {
                Text("ABDUCTION ADDUCTION")
                    .font(.system(size: 25, weight: .bold))
                    .frame(width: 300, height: 100)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Text("RIGHT HIP MOVEMENTS")
                .font(.system(size: 30, weight: .bold))
            NavigationLink(destination: StoryboardViewWrapper(joint: .hip , bodySide: .right, recordDirection: .side)) {
                Text("FLEXION EXTENSION")
                    .font(.system(size: 25, weight: .bold))
                    .frame(width: 300, height: 100)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            NavigationLink(destination: StoryboardViewWrapper(joint: .hip , bodySide: .left, recordDirection: .front)) {
                Text("ABDUCTION ADDUCTION")
                    .font(.system(size: 25, weight: .bold))
                    .frame(width: 300, height: 100)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
        }
        .padding()
    }
}

