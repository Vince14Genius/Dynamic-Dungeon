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
        
        for _ in 1 ... 9 {
            previousRowPool     = nil
            rowsGenerated = 0
            
            generateTiles()
        }
        for _ in 10 ... 12 {
            generateTiles()
        }
        
        // MARK: Hero setup
        
        hero.texture   = SKTexture(image: #imageLiteral(resourceName: "hero"))
        hero.size      = CGSize(width: GameParameters.squareSide, height: GameParameters.squareSide)
        hero.position  = CGPoint(x: 0, y: 0)
        hero.zPosition = ZIndices.hero
        
        allTiles.children[7].children[3].addChild(hero)
        
        // MARK: Gameplay start
        
        effects.startingInstructions()
        refreshLoop()
    }
}
