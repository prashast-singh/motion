//
//  KneeView.swift
//  MotionAnalysis
//
//  Created by Prashast Singh on 04.11.24.
//

import SwiftUI
import Foundation

struct KneeView : View {
    var body: some View {
        VStack(spacing: 20) {
            Text("LEFT KNEE MOVEMENTS")
                .font(.system(size: 30, weight: .bold))
            
            NavigationLink(destination: StoryboardViewWrapper(joint: .knee , bodySide: .left, recordDirection: .side)) {
                Text("FLEXION EXTENSION")
                    .font(.system(size: 25, weight: .bold))
                    .frame(width: 300, height: 100)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Text("RIGHT KNEE MOVEMENTS")
                .font(.system(size: 30, weight: .bold))
            
            
            NavigationLink(destination: StoryboardViewWrapper(joint: .hip , bodySide: .right, recordDirection: .side)) {
                Text("FLEXION EXTENSION")
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
