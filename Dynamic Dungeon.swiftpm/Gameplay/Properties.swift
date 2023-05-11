//
//  Properties.swift
//  Dynamic Dungeon
//
//  Created by Vincent Cai [STUDENT] on 17/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

let squareSide = width / 6

// Tweak the numbers here for the right scrolling speed and acceleration
let initialSpeedDuration   = 0.6
let finalSpeedDuration     = 0.1
let speedIncreaseRateBase  = 0.1
let speedIncreaseRatePower = 0.1

class Tile : SKNode {
    var node : SKSpriteNode
    var x    : Int
    var type : TileType
    
    init(type inputType: TileType, xCoordinate: (Int)) {
        type = inputType
        x    = xCoordinate
        
        switch type {
        case .path:
            node = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "tileRoad")))
            node.zPosition = zOfTiles
        case .wall:
            node = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "tileWall")))
            node.zPosition = zOfTiles + 0.1
        }
        
        super.init()
        
        node.size = CGSize(width: squareSide, height: squareSide)
        position  = CGPoint(x: CGFloat(xCoordinate - 1) * (squareSide) + (squareSide / 2), y: 0)
        
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func turnIntoPath() {
        type = .path
        node.texture = SKTexture(image: #imageLiteral(resourceName: "tileRoad"))
        node.zPosition = zOfTiles
    }
    
    func turnIntoWall() {
        type = .path
        node.texture = SKTexture(image: #imageLiteral(resourceName: "tileWall"))
        node.zPosition = zOfTiles
    }
}

class AddOn : SKNode {
    var node : SKSpriteNode
    var type : AddonType
    let game: Game
    
    init(type inputType: AddonType, game: Game) {
        self.game = game
        type = inputType
        
        switch type {
        case .star:
            node = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "addonStar")))
            node.alpha = 0.5
        case .litStar:
            node = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "addonStarActivated")))
            node.alpha = 0.75
        case .specialAttack:
            node = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "addonAttack")))
            
        case .specialAttackWindup:
            node = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "addonAttackWindup")))
        case .wallAttackWindup:
            node = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "addonBuildAWall")))
        }
        
        super.init()
        set(type: inputType, game: game)
        
        node.zPosition = zOfEffects
        node.size = CGSize(width: squareSide, height: squareSide)
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(type inputType: AddonType, game: Game) {
        type = inputType
        switch type {
        case .star:
            node.texture = SKTexture(image: #imageLiteral(resourceName: "addonStar"))
            node.alpha = 0.5
            node.run(.repeatForever(.rotate(byAngle: 2 * .pi, duration: 4.0)))
        case .litStar:
            node.texture = SKTexture(image: #imageLiteral(resourceName: "addonStarActivated"))
            node.alpha = 0.75
            node.run(.repeatForever(.rotate(byAngle: 2 * .pi, duration: 1.0)))
        case .specialAttack:
            node.texture = SKTexture(image: #imageLiteral(resourceName: "addonAttack"))
            run(.sequence([
                .rotate(byAngle: 4 * .pi, duration: 0.5),
                .removeFromParent()
                ]))
            for i in (parent?.children)! {
                if i === game.hero {
                    effectStunned(game: game)
                    superpowerOn = false
                    game.hero.run(.sequence([
                        .wait(forDuration: 0.5),
                        .run {
                            inAction = false
                        }
                        ]))
                }
            }
        case .specialAttackWindup:
            node.texture = SKTexture(image: #imageLiteral(resourceName: "addonAttackWindup"))
            run(.sequence([
                .rotate(byAngle: 2 * .pi, duration: 1.0),
                .run {
                    self.set(type: .specialAttack, game: game)
                }
                ]))
        case .wallAttackWindup:
            node.texture = SKTexture(image: #imageLiteral(resourceName: "addonBuildAWall"))
            run(.sequence([
                .fadeOut(withDuration: 1.0),
                .run {
                    (self.parent! as! Tile).turnIntoWall()
                },
                .removeFromParent()
                ]))
        }
    }
    
    func testStar() {
        if type == .star {
            set(type: .litStar, game: game)
            game.score += 1
        }
    }
}
