//
//  File.swift
//  
//
//  Created by Vincent C. on 5/11/23.
//

import SpriteKit

extension Game {
    func tryMovement(xShift: CGFloat, yShift: CGFloat) {
        let duration = 0.04
        
        let moveHalf = SKAction.move(to: CGPoint(x: xShift / 2, y: yShift / 2), duration: duration)
        
        let moveBack = SKAction.sequence([
            .move(to: CGPoint(x: 0, y: 0), duration: duration),
            .wait(forDuration: 0.1),
            .run {
                self.loseSuperpower()
                self.isInAction = false
            }
        ])
        
        let determine = SKAction.run {
            
            let determineX = self.hero.parent!.position.x + xShift
            let determineY = self.hero.parent!.parent!.position.y + yShift
            
            let nodes = self.allTiles.nodes(at: CGPoint(x: determineX, y: determineY))
            
            var determined = false
            
            if determineX < 0 || determineX > Dimensions.width || determineY > Dimensions.height {
                self.loseSuperpower()
                self.hero.run(moveBack)
                return
            }
            
            for node in nodes {
                if
                    !determined,
                    let tile = node as? Tile
                {
                    let moveFull = SKAction.sequence([
                        .move(to: CGPoint(x: xShift, y: yShift), duration: 0.1),
                        .run {
                            self.testForSuperpower()
                            self.hero.removeFromParent()
                            tile.addChild(self.hero)
                            self.hero.position = .zero
                            
                            var isStunned = false
                            for child in self.hero.parent!.children {
                                if let addOn = child as? AddOn {
                                    switch addOn.type {
                                    case .star:
                                        self.effects.scoreIncreased()
                                        addOn.testStar()
                                    case .specialAttack:
                                        isStunned = true
                                    default: break
                                    }
                                }
                            }
                            
                            if isStunned {
                                let stunDuration = self.useSuperpower() ? 0.5 : 1.0
                                self.effects.stunned()
                                self.hero.run(.sequence([
                                    .wait(forDuration: stunDuration),
                                    .run { self.isInAction = false }
                                ]))
                            } else {
                                self.isInAction = false
                            }
                        }])
                    
                    if tile.type == .path {
                        self.hero.run(moveFull)
                    } else {
                        if self.useSuperpower() {
                            tile.turnIntoPath()
                            self.hero.run(moveFull)
                        } else {
                            self.hero.run(moveBack)
                        }
                    }
                    determined = true
                }
            }
            
            if !determined {
                self.loseSuperpower()
                self.hero.run(moveBack)
            }
        }
        
        hero.run(.sequence([moveHalf, determine]))
    }

}
