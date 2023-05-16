//
//  ScoreLabel.swift
//  
//
//  Created by Vincent C. on 5/16/23.
//

import SwiftUI

struct ScoreLabel: View {
    @Binding var score: Int
    @State var scale = 1.0
    
    let animateDuration = 0.15
    
    var body: some View {
        Text("\(score)★")
            .scaleEffect(scale)
            .font(.title)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.accentColor)
            .onChange(of: score) { _ in
                scale = 1.25
                _ = Timer.scheduledTimer(withTimeInterval: animateDuration, repeats: false) { _ in
                    scale = 1.0
                }
            }
            .animation(.easeOut(duration: animateDuration), value: scale)
    }
}

struct ScoreLabel_Previews: PreviewProvider {
    static var previews: some View {
        ScoreLabel(score: .constant(69))
    }
}
