//
//  SpinnerView.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import SwiftUI

enum ScaleSize: CGFloat {
    case small = 1.0
    case medium = 2.0
    case large = 3.0
}

struct SpinnerView: View {
    
    var isVisible: Bool = false
    var tintColor: Color = Color(uiColor: .label)
    var scaleSize: ScaleSize = .medium
    
    var body: some View {
        Group {
            isVisible ? customProgressView : nil
        }
    }
    
    var customProgressView: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
                .scaleEffect(scaleSize.rawValue, anchor: .center)
        }
    }
}
struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
