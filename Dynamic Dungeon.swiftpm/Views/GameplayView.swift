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
    
    @StateObject var game = Game()
    
    var body: some View {
        ZStack {
            SpriteView(scene: game.scene)
                .ignoresSafeArea()
            Group {
                if game.isPaused {
                    Color(white: 0, opacity: 0.5)
                    Text("Paused")
                        .foregroundColor(.white)
                }
            }
            .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        game.isPaused.toggle()
                    } label: {
                        Image(systemName: game.isPaused ? "play.fill" : "pause.fill")
                            .resizable()
                            .padding()
                    }
                    .frame(width: 56, height: 56)
                    Spacer()
                    Text("\(game.score)★")
                        .font(.title)
                        .foregroundColor(Color.accentColor)
                    Spacer()
                    Button {
                        game.isPaused = true
                        isShowingExitAlert = true
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .padding()
                    }
                    .frame(width: 56, height: 56)
                }
                Spacer()
            }
        }
        .alert("Exit to Title", isPresented: $isShowingExitAlert) {
            Button("Cancel", role: .cancel) {
                isShowingExitAlert = false
                game.isPaused = false
            }
            Button("Quit", role: .destructive) {
                isShowingExitAlert = false
                navigationState = .title
            }
        } message: {
            Text("Are you sure you want to quit? Your progress will not be saved.")
        }
        .onChange(of: game.isGameOver) { newValue in
            if newValue {
                navigationState = .gameover(score: game.score)
            }
        }
    }
}

struct GameplayView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayView(navigationState: .constant(.gameplay))
    }
}
