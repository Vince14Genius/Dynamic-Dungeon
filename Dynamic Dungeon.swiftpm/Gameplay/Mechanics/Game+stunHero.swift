//
//  Game+stunHero.swift
//  
//
//  Created by Vincent C. on 5/11/23.
//

import SpriteKit

extension Game {
    func stunHero() {
        // initialize stun icon
        
        let stunIcon = SKLabelNode(text: "💫")
        stunIcon.fontSize = GameParameters.squareSide / 3
        let stunIconShift = GameParameters.squareSide / 4
        stunIcon.position = .init(x: stunIconShift, y: stunIconShift)
        stunIcon.zPosition = ZIndices.effects
        
        // determine stun type based on superpower
        
        let stunDuration: TimeInterval
        if useSuperpower() {
            stunDuration = GameParameters.stunDurationWithSuperpower
            effects.superpowerUsed()
            stunIcon.isHidden = true
        } else {
            stunDuration = GameParameters.stunDuration
        }
        
        // perform stun
        
        isInAction = true
        effects.stunned()
        hero.removeAllActions()
        hero.run(.sequence([
            .move(to: .zero, duration: 0),
            .run {
                self.hero.effectNode.filter = .init(name: "CIPhotoEffectMono")
                self.hero.effectNode.addChild(stunIcon)
            },
            .wait(forDuration: stunDuration),
            .run {
                self.isInAction = false
                self.hero.effectNode.filter = nil
                stunIcon.removeFromParent()
            }
        ]))
    }
}
