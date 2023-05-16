//
//  Hero.swift
//  
//
//  Created by Vincent C. on 5/15/23.
//

import SpriteKit

class Hero: SKNode {
    var texture: SKTexture! {
        didSet { sprite.texture = texture }
    }
    
    private let sprite = SKSpriteNode(texture: .init(image: #imageLiteral(resourceName: "hero")))
    internal let effectNode = SKEffectNode()
    
    override init() {
        super.init()
        addChild(effectNode)
        effectNode.addChild(sprite)
        texture = sprite.texture
        
        sprite.size = CGSize(width: GameParameters.squareSide, height: GameParameters.squareSide)
        zPosition = ZIndices.hero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
