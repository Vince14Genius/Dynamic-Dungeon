//
//  Game+spawnAttacks.swift
//  
//
//  Created by Vincent C. on 5/15/23.
//

import Foundation

extension Game {
    func spawnAttacks() {
        for row in allTiles.children {
            for element in row.children {
                guard
                    let tile = element as? Tile,
                    tile.type == .path
                else { continue }
                spawnAttack(on: tile)
            }
        }
    }
    
    private func spawnAttack(on tile: Tile) {
        switch Double.random(in: 0 ..< 1) {
        case 0 ..< stunAttackChance:
            // spawn stun attack
            guard
                !tile.hasAddOn(type: .wallAttackWindup),
                !tile.hasAddOn(type: .stunAttackWindup)
                // allow stun attack windups to be spawned on top of
                // stun attacks, but not other stun attack windups
            else { break }
            tile.addChild(
                AddOn(
                    type: .stunAttackWindup,
                    game: self
                )
            )
        case stunAttackChance ..< stunAttackChance + GameParameters.wallAttackChance:
            // spawn wall attack
            guard !tile.hasAddOns else { break }
            tile.addChild(
                AddOn(
                    type: .wallAttackWindup,
                    game: self
                )
            )
        default:
            break
        }
    }
}
