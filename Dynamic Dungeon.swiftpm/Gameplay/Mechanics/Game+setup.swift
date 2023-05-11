//
//  File.swift
//  
//
//  Created by Vincent C. on 5/10/23.
//

import SpriteKit

extension Game {
    func setup() {
        // MARK: generate initial tiles
        
        for _ in 1 ... 7 {
            lastCombo     = nil
            rowsGenerated = 0
            
            generateTiles()
        }
        for _ in 8 ... 9 {
            generateTiles()
        }
        
        // MARK: Hero setup
        
        hero.texture   = SKTexture(image: #imageLiteral(resourceName: "hero"))
        hero.size      = CGSize(width: GameParameters.squareSide, height: GameParameters.squareSide)
        hero.position  = CGPoint(x: 0, y: 0)
        hero.zPosition = ZIndices.hero
        
        allTiles.children[4].children[3].addChild(hero)
        
        // MARK: Gameplay start
        
        effects.startingInstructions()
        refreshLoop()
    }
    
    func refreshLoop() {
        allTiles.run(
            .move(
                to: CGPoint(x: 0, y: -GameParameters.squareSide),
                duration: mazeRowScrollDuration
            )
        ) { [weak self] in
            guard let self else { return }
            defer { self.refreshLoop() }
            
            self.allTiles.children[0].removeFromParent()
            for child in self.allTiles.children {
                child.position.y -= GameParameters.squareSide
            }
            generateTiles()
            if let heroY = self.hero.parent?.parent?.position.y {
                if heroY <= 0 {
                    self.isGameOver = true
                }
            }
        }
    }
}
