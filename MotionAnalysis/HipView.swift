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
            Text("HIP MOVEMENTS")
                .font(.system(size: 30, weight: .bold))
            
            Button("FLEXION EXTENSTION") {
                // Action for Flexion
            }
            .font(.system(size: 25, weight: .bold))
            .frame(width: 300, height: 100)
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button("ABDUCTION ADDUCTION") {
                // Action for Flexion
            }
            .font(.system(size: 25, weight: .bold))
            .frame(width: 300, height: 100)
            .background(Color.black)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
        .padding()
    }
}
