//
//  Game+DifficultyRampUp.swift
//  
//
//  Created by Vincent C. on 5/10/23.
//

import Foundation

extension Game {
    // Using expected score instead of actual score
    // to force players to make a choice between
    // surviving and getting a star
    private var expectedScore: Double {
        Double(rowsGenerated) / Double(GameParameters.rowGenerationsNeededPerStar)
    }
    
    var mazeRowScrollDuration: Double {
        let speed = 1 + expectedScore * GameParameters.scoreToAdditionalSpeedMultiplier
        return GameParameters.initialSpeedDuration / speed
    }
    
    var stunAttackChance: Double {
        min(
            GameParameters.stunAttackChanceLimit,
            GameParameters.initialStunAttackChance + expectedScore * GameParameters.scoreToAdditionalStunAttackChanceMultiplier
        )
    }
}
