//
//  GameOverView.swift
//  Dynamic Dungeon
//
//  Created by Vincent C. on 5/10/23.
//

import SwiftUI

struct GameOverView: View {
    let score: Int
    @Binding var navigationState: NavigationState
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.267647069692612, green: 0.0545098069310188, blue: 0.0174509806185961, alpha: 1.0))
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("You have perished.")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Text("Score: \(score)")
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
                Button("Return to Title") {
                    navigationState = .title
                }
                .buttonStyle(.bordered)
                Spacer()
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(score: 69, navigationState: .constant(.gameover(score: 69)))
    }
}
