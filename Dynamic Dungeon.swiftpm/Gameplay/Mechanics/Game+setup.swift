//
//  Game+setup.swift
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
        
        allTiles.children[7].children[3].addChild(hero)
        
        // MARK: Gameplay start
        
        effects.startingInstructions()
        refreshLoop()
    }
}
