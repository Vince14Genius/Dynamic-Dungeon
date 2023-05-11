//
//  Basics.swift
//  Dynamic Dungeon
//
//  Created by Vincent Cai [STUDENT] on 17/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

let height: CGFloat = 960
let width: CGFloat = height * 3 / 4
let size = CGSize(width: width, height: height)
let widthHalf  = width / 2
let heightHalf = height / 2

enum TileType {
    case path
    case wall
}

enum AddonType {
    case star
    case litStar
    case specialAttackWindup
    case specialAttack
    case wallAttackWindup
}

let zOfButtons : CGFloat = 15
let zOfTiles   : CGFloat = 1
let zOfEffects : CGFloat = 2
let zOfHero    : CGFloat = 3
let zOfEnemy   : CGFloat = 4
let zOfShadows : CGFloat = 10

let keyCodeEsc  : UInt16 = 53
let keyCodeA    : UInt16 = 0
let keyCodeS    : UInt16 = 1
let keyCodeD    : UInt16 = 2
let keyCodeW    : UInt16 = 13
let keyCodeLeft : UInt16 = 123
let keyCodeRight: UInt16 = 124
let keyCodeDown : UInt16 = 125
let keyCodeUp   : UInt16 = 126

func createLabel(x: CGFloat, y: CGFloat, size: CGFloat, text: String) -> SKLabelNode {
    let node = SKLabelNode(fontNamed: "AvenirNext-Regular")
    node.color = #colorLiteral(red: 0.474509805440903, green: 0.839215695858002, blue: 0.976470589637756, alpha: 1.0)
    node.horizontalAlignmentMode = .center
    node.verticalAlignmentMode = .center
    node.numberOfLines = 0
    
    node.position  = CGPoint(x: x, y: y)
    node.fontSize  = size
    node.text      = text
    node.zPosition = zOfButtons
    return node
}

func gameSetup(gameState: GameState) {
    gameState.allTiles.removeAllChildren()
    gameState.allTiles.removeAllActions()
    gameState.hero.removeAllActions()
    
    rowsGenerated = 0
    speedDuration = finalSpeedDuration + (initialSpeedDuration - finalSpeedDuration) / (Double(powf(Float(1 + speedIncreaseRateBase), Float(Double(rowsGenerated) * speedIncreaseRatePower))))
    
    lastRow   = nil
    lastCombo = nil
    
    inAction     = false
    superpowerOn = false
    combo        = 0
    
    gameState.hero.texture   = SKTexture(image: #imageLiteral(resourceName: "hero"))
    gameState.hero.size      = CGSize(width: squareSide, height: squareSide)
    gameState.hero.position  = CGPoint(x: 0, y: 0)
    gameState.hero.zPosition = zOfHero
    
    for _ in 1 ... 5 {
        lastCombo     = nil
        rowsGenerated = 0
        
        generateTiles(gameState: gameState)
    }
    for _ in 6 ... 9 {
        generateTiles(gameState: gameState)
    }
    
    gameState.allTiles.children[4].children[3].addChild(gameState.hero)
    
    effectGameStart(scene: gameState.allTiles.scene!)
    
    gameState.allTiles.run(
        .repeatForever(
            .sequence([
                .move(
                    to: CGPoint(x: 0, y: -squareSide),
                    duration: speedDuration
                ),
                .run {
                    gameState.allTiles.children[0].removeFromParent()
                    for child in gameState.allTiles.children {
                        child.position.y -= squareSide
                    }
                    generateTiles(gameState: gameState)
                    speedDuration = finalSpeedDuration + (initialSpeedDuration - finalSpeedDuration) / (Double(powf(Float(1 + speedIncreaseRateBase), Float(Double(rowsGenerated) * speedIncreaseRatePower))))
                    if let heroY = gameState.hero.parent?.parent?.position.y {
                        if heroY <= 0 {
                            gameState.isGameOver = true
                        }
                    }
                }
            ])
        )
    )
}