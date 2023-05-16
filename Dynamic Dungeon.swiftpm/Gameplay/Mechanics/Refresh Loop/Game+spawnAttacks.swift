//
//  File.swift
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
            tile.addChild(
                AddOn(
                    type: .stunAttackWindup,
                    game: self
                )
            )
        case stunAttackChance ..< stunAttackChance + GameParameters.wallAttackChance:
            // spawn wall attack
            guard !tile.hasAddOn(type: .star) else { break }
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
