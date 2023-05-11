//
//  File.swift
//  
//
//  Created by Vincent C. on 5/10/23.
//

import SpriteKit

extension Game {
    func setup() {
        // MARK: magic global variables lol
        
        rowsGenerated = 0
        speedDuration = finalSpeedDuration + (initialSpeedDuration - finalSpeedDuration) / (Double(powf(Float(1 + speedIncreaseRateBase), Float(Double(rowsGenerated) * speedIncreaseRatePower))))
        
        // MARK: generate initial tiles
        
        for _ in 1 ... 5 {
            lastCombo     = nil
            rowsGenerated = 0
            
            generateTiles()
        }
        for _ in 6 ... 9 {
            generateTiles()
        }
        
        // MARK: Hero setup
        
        hero.texture   = SKTexture(image: #imageLiteral(resourceName: "hero"))
        hero.size      = CGSize(width: squareSide, height: squareSide)
        hero.position  = CGPoint(x: 0, y: 0)
        hero.zPosition = ZIndices.hero
        
        allTiles.children[4].children[3].addChild(hero)
        
        // MARK: Gameplay start
        
        effects.startingInstructions()
        
        allTiles.run(.repeatForever(.sequence([
            .move(
                to: CGPoint(x: 0, y: -squareSide),
                duration: speedDuration
            ),
            .run { [weak self] in
                guard let self else { return }
                self.allTiles.children[0].removeFromParent()
                for child in self.allTiles.children {
                    child.position.y -= squareSide
                }
                generateTiles()
                speedDuration = finalSpeedDuration + (initialSpeedDuration - finalSpeedDuration) / (Double(powf(Float(1 + speedIncreaseRateBase), Float(Double(rowsGenerated) * speedIncreaseRatePower))))
                if let heroY = self.hero.parent?.parent?.position.y {
                    if heroY <= 0 {
                        self.isGameOver = true
                    }
                }
            }
        ])))
    }
}
