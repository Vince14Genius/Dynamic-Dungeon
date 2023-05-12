//
//  File.swift
//  
//
//  Created by Vincent C. on 5/11/23.
//

import SpriteKit

extension Game {
    func tryMovement(xShift: CGFloat, yShift: CGFloat) {
        let moveHalf = SKAction.move(to: CGPoint(x: xShift / 2, y: yShift / 2), duration: 0.04)
        
        let moveBack = SKAction.sequence([
            .move(to: CGPoint(x: 0, y: 0), duration: 0.04),
            .wait(forDuration: 0.1),
            .run {
                self.loseSuperpower()
                self.isInAction = false
            }
        ])
        
        func moveFull(tile: Tile) -> SKAction {
            .sequence([
                .move(to: CGPoint(x: xShift, y: yShift), duration: 0.1),
                .run {
                    self.testForSuperpower()
                    self.hero.removeFromParent()
                    tile.addChild(self.hero)
                    self.hero.position = .zero
                    
                    self.isInAction = false
                    for child in self.hero.parent!.children {
                        guard let addOn = child as? AddOn else { continue }
                        switch addOn.type {
                        case .star:
                            self.effects.scoreIncreased()
                            addOn.testStar()
                        case .stunAttack:
                            self.stunHero()
                        default: break
                        }
                    }
                }
            ])
        }
        
        let determine = SKAction.run {
            
            let determineX = self.hero.parent!.position.x + xShift
            let determineY = self.hero.parent!.parent!.position.y + yShift
            
            let nodes = self.allTiles.nodes(at: CGPoint(x: determineX, y: determineY))
            
            var isMoveDestinationATile = false
            
            if determineX < 0 || determineX > Dimensions.width || determineY > Dimensions.height {
                self.loseSuperpower()
                self.hero.run(moveBack)
                return
            }
            
            for node in nodes {
                guard let tile = node as? Tile else { continue }
                
                if tile.type == .path {
                    self.hero.run(moveFull(tile: tile))
                } else if self.useSuperpower() {
                    tile.turnIntoPath()
                    self.hero.run(moveFull(tile: tile))
                } else {
                    self.hero.run(moveBack)
                }
                
                isMoveDestinationATile = true
                break
            }
            
            if !isMoveDestinationATile {
                self.loseSuperpower()
                self.hero.run(moveBack)
            }
        }
        
        hero.run(.sequence([moveHalf, determine]))
    }

}
