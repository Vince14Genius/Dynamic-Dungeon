//
//  GameplayView.swift
//  Dynamic Dungeon
//
//  Created by Vincent C. on 5/9/23.
//

import SwiftUI
import SpriteKit

struct GameplayView: View {
    @State var isShowingExitAlert = false
    @Binding var navigationState: NavigationState
    
    @StateObject var gameState = GameState()
    
    var body: some View {
        ZStack {
            SpriteView(scene: gameState.scene)
                .ignoresSafeArea()
            Group {
                if gameState.isPaused {
                    Color(white: 0, opacity: 0.5)
                    Text("Paused")
                        .foregroundColor(.white)
                }
            }
            .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        gameState.isPaused.toggle()
                    } label: {
                        Image(systemName: gameState.isPaused ? "play.fill" : "pause.fill")
                            .resizable()
                            .padding()
                    }
                    .frame(width: 44, height: 44)
                    Spacer()
                    Text("Score: \(gameState.score)")
                        .font(.title2)
                        .foregroundColor(Color.accentColor)
                    Spacer()
                    Button {
                        isShowingExitAlert = true
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .padding()
                    }
                    .frame(width: 44, height: 44)
                }
                Spacer()
            }
        }
        .alert("Exit to Title", isPresented: $isShowingExitAlert) {
            Button("Cancel", role: .cancel) {
                isShowingExitAlert = false
            }
            Button("Quit", role: .destructive) {
                isShowingExitAlert = false
                navigationState = .title
            }
        } message: {
            Text("Are you sure you want to quit? Your progress will not be saved.")
        }
        .onChange(of: gameState.isGameOver) { newValue in
            if newValue {
                navigationState = .gameover(score: gameState.score)
            }
        }
    }
}

struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView(navigationState: .constant(.gameplay))
    }
}
