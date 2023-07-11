//
//  Effects.swift
//  Dynamic Dungeon
//
//  Created by Vincent C. on 20/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

class Effects {
    unowned var game: Game
    init(game: Game) {
        self.game = game
    }
    
    static func createLabel(x: CGFloat, y: CGFloat, size: CGFloat, text: String) -> SKLabelNode {
        let node = SKLabelNode(fontNamed: "AvenirNext-Regular")
        node.color = #colorLiteral(red: 0.474509805440903, green: 0.839215695858002, blue: 0.976470589637756, alpha: 1.0)
        node.horizontalAlignmentMode = .center
        node.verticalAlignmentMode = .center
        node.numberOfLines = 0
        
        node.position  = CGPoint(x: x, y: y)
        node.fontSize  = size
        node.text      = text
        node.zPosition = ZIndices.labels
        return node
    }
}

private let defaultEffectAction = SKAction.sequence([
    .fadeIn(withDuration: 0.1),
    .wait(forDuration: 0.1),
    .fadeOut(withDuration: 0.3),
    .removeFromParent()
])

extension Effects {
    private func presentHeroEffectLabel(text: String, size: CGFloat, duration: TimeInterval) {
        let effect = Effects.createLabel(x: 0, y: Dimensions.heightHalf / 18, size: size, text: text)
        effect.zPosition = ZIndices.labels
        
        game.hero.addChild(effect)
        effect.run(defaultEffectAction)
        effect.run(.moveBy(x: 0, y: Dimensions.height / 18, duration: duration))
    }

    func scoreIncreased() {
        presentHeroEffectLabel(
            text: "+1",
            size: Dimensions.height / 18,
            duration: 0.5
        )
    }

    func stunned() {
        presentHeroEffectLabel(
            text: "Stunned",
            size: Dimensions.height / 24,
            duration: 0.5
        )
    }
    
    func wallSpawnDenied() {
        presentHeroEffectLabel(
            text: "wall spawn\ndenied",
            size: Dimensions.height / 32,
            duration: 0.3
        )
    }

    func superpowerGranted() {
        presentHeroEffectLabel(
            text: "wallbreaker",
            size: Dimensions.height / 32,
            duration: 0.3
        )
    }

    func superpowerUsed() {
        presentHeroEffectLabel(
            text: "wallbreaker\nused",
            size: Dimensions.height / 36,
            duration: 0.3
        )
    }
}
