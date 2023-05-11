//
//  Input.swift
//  Dynamic Dungeon
//
//  Created by Vincent Cai [STUDENT] on 20/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

// MARK: Sliding Controls

var inAction = false

func slideTest(xShift: CGFloat, yShift: CGFloat, gameState: GameState) {
    var duration = 0.04
    if superpowerOn {
        duration = 0.04
    }
    
    let moveHalf = SKAction.move(to: CGPoint(x: xShift / 2, y: yShift / 2), duration: duration)
    
    let moveBack = SKAction.sequence([
        .move(to: CGPoint(x: 0, y: 0), duration: duration),
        .wait(forDuration: 0.1),
        .run {
            superpowerOff(gameState: gameState)
            inAction = false
        }])
    
    let determine = SKAction.run {
        
        let determineX = (gameState.hero.parent?.position.x)! + xShift
        let determineY = (gameState.hero.parent?.parent?.position.y)! + yShift
        
        let nodes      = gameState.allTiles.nodes(at: CGPoint(x: determineX, y: determineY))
        
        var determined = false
        
        if determineX < 0 || determineX > width || determineY > height {
            superpowerOff(gameState: gameState)
            gameState.hero.run(moveBack)
            return
        }
        
        for node in nodes {
            if !determined {
                if let tile = node as? Tile {
                    let moveFull = SKAction.sequence([
                        .move(to: CGPoint(x: xShift, y: yShift), duration: 0.1),
                        .run {
                            testForSuperpower(gameState: gameState)
                            gameState.hero.removeFromParent()
                            tile.addChild(gameState.hero)
                            gameState.hero.position = CGPoint(x: 0, y: 0)
                            
                            var stunned = false
                            for child in (gameState.hero.parent?.children)! {
                                if let addOn = child as? AddOn {
                                    switch addOn.type {
                                    case .star:
                                        effectAddScore(gameState: gameState)
                                        addOn.testStar()
                                    case .specialAttack: stunned = true
                                    default: break
                                    }
                                }
                            }
                            if stunned {
                                if superpowerUse(gameState: gameState) {
                                    effectStunned(gameState: gameState)
                                    gameState.hero.run(.sequence([
                                        .wait(forDuration: 0.5),
                                        .run {
                                            inAction = false
                                        }
                                        ]))
                                } else {
                                    effectStunned(gameState: gameState)
                                    gameState.hero.run(.sequence([
                                        .wait(forDuration: 1.0),
                                        .run {
                                            inAction = false
                                        }
                                        ]))
                                }
                            } else {
                                inAction = false
                            }
                        }])
                    
                    if tile.type == .path {
                        gameState.hero.run(moveFull)
                    } else {
                        if superpowerUse(gameState: gameState) {
                            tile.turnIntoPath()
                            gameState.hero.run(moveFull)
                        } else {
                            gameState.hero.run(moveBack)
                        }
                    }
                    determined = true
                }
            }
        }
        
        if !determined {
            superpowerOff(gameState: gameState)
            gameState.hero.run(moveBack)
        }
    }
    
    gameState.hero.run(.sequence([moveHalf, determine]))
}

func slide(begin: CGPoint, end: CGPoint, gameState: GameState) {
    if !inAction {
        let xDiff = end.x - begin.x
        let yDiff = end.y - begin.y
        let angle = Double(atan2(yDiff, xDiff))
        
        inAction = true
        
        switch angle {
        case -(3 * .pi / 4) ..<    -(.pi / 4): /* Down  */ slideTest(xShift: 0, yShift: -squareSide, gameState: gameState)
        case     -(.pi / 4) ..<     (.pi / 4): /* Right */ slideTest(xShift: squareSide, yShift: 0, gameState: gameState)
        case      (.pi / 4) ..< (3 * .pi / 4): /* Up    */ slideTest(xShift: 0         , yShift: squareSide, gameState: gameState)
        default                              : /* Left  */ slideTest(xShift: -squareSide, yShift: 0, gameState: gameState)
        }
    }
}

// MARK: Handling Input

var previousInputPoint : CGPoint?

func inputBegan(touchPoint: CGPoint, gameState: GameState) {
    previousInputPoint = touchPoint
}

func inputEnded(touchPoint: CGPoint, gameState: GameState) {
    defer { previousInputPoint = nil }
    
    if let begin = previousInputPoint {
        slide(begin: begin, end: touchPoint, gameState: gameState)
    }
}

// MARK: Scenes

func slideWithKeys(xShift: CGFloat, yShift: CGFloat, gameState: GameState) {
    if !inAction {
        inAction = true
        slideTest(xShift: xShift, yShift: yShift, gameState: gameState)
    }
}
