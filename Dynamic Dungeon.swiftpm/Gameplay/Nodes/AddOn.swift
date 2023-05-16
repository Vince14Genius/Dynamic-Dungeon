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
        case .stunAttack:
            node = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "addonAttack")))
            
        case .stunAttackWindup:
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
            node.run(.repeatForever(.rotate(byAngle: 2 * .pi, duration: 0.8)))
        case .stunAttack:
            node.texture = SKTexture(image: #imageLiteral(resourceName: "addonAttack"))
            run(.sequence([
                .rotate(byAngle: 4 * .pi, duration: GameParameters.stunAttackAppearDuration),
                .removeFromParent()
                ]))
            for child in parent!.children {
                guard child === game.hero else { continue }
                game.stunHero()
            }
        case .stunAttackWindup:
            node.texture = SKTexture(image: #imageLiteral(resourceName: "addonAttackWindup"))
            run(.sequence([
                .rotate(byAngle: 2 * .pi, duration: GameParameters.stunAttackWindupTime),
                .run {
                    self.set(type: .stunAttack, game: game)
                }
                ]))
        case .wallAttackWindup:
            node.texture = SKTexture(image: #imageLiteral(resourceName: "addonBuildAWall"))
            run(.sequence([
                .fadeOut(withDuration: GameParameters.stunAttackWindupTime),
                .run {
                    for child in self.parent!.children {
                        if child === game.hero {
                            game.effects.wallSpawnDenied()
                            return
                        }
                    }
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
