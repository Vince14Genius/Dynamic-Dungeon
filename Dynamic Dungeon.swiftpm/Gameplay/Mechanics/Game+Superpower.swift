//
//  Superpower.swift
//  
//
//  Created by Vincent C. on 5/10/23.
//

import SpriteKit

extension Game {
    func testForSuperpower() {
        combo += 1
        if combo >= 4 {
            if !isSuperpowerOn {
                effects.superpowerGranted()
            }
            isSuperpowerOn = true
            hero.texture = .init(imageNamed: "heroSwift")
        }
    }

    func useSuperpower() -> Bool {
        let wasSuperpowerOn = isSuperpowerOn
        if isSuperpowerOn {
            effects.superpowerUsed()
        }
        isSuperpowerOn = false
        combo = 0
        hero.texture = .init(imageNamed: "hero")
        return wasSuperpowerOn
    }

    func loseSuperpower() {
        isSuperpowerOn = false
        combo = 0
        hero.texture = .init(imageNamed: "hero")
    }
}
