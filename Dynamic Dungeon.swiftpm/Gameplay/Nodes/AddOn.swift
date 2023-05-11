//
//  AddOn.swift
//  
//
//  Created by Vincent C. on 5/10/23.
//

import SpriteKit

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
        
        node.zPosition = ZIndices.effects
        node.size = CGSize(width: GameParameters.squareSide, height: GameParameters.squareSide)
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
                    game.effects.stunned()
                    game.isSuperpowerOn = false
                    game.hero.run(.sequence([
                        .wait(forDuration: 0.5),
                        .run {
                            game.isInAction = false
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
