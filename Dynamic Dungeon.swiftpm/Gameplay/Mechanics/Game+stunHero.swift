//
//  Game+stunHero.swift
//  
//
//  Created by Vincent C. on 5/11/23.
//

import SpriteKit

extension Game {
    func stunHero() {
        let stunDuration: TimeInterval
        if useSuperpower() {
            stunDuration = GameParameters.stunDurationWithSuperpower
            effects.superpowerUsed()
        } else {
            stunDuration = GameParameters.stunDuration
        }
        
        isInAction = true
        effects.stunned()
        hero.removeAllActions()
        hero.run(.sequence([
            .move(to: .zero, duration: 0),
            .wait(forDuration: stunDuration),
            .run { self.isInAction = false }
        ]))
    }
}
