//
//  Game+refreshLoop.swift
//  
//
//  Created by Vincent C. on 5/15/23.
//

import SpriteKit

extension Game {
    func refreshLoop() {
        allTiles.run(
            .move(
                to: CGPoint(x: 0, y: -GameParameters.squareSide),
                duration: mazeRowScrollDuration
            )
        ) { [weak self] in
            guard let self else { return }
            
            // tail-recursion call
            defer { self.refreshLoop() }
            
            // game-over check
            self.isGameOver = self.hero.parent?.parent == nil
            if
                let heroY = self.hero.parent?.parent?.position.y,
                heroY <= 0
            { self.isGameOver = true }
            
            // row shifting
            self.allTiles.children[0].removeFromParent()
            for child in self.allTiles.children {
                child.position.y -= GameParameters.squareSide
            }
            
            // generate
            generateTiles()
            spawnAttacks()
        }
    }
}
