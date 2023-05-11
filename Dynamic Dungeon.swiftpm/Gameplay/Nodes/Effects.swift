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
}

private func createLabel(x: CGFloat, y: CGFloat, size: CGFloat, text: String) -> SKLabelNode {
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

private let defaultEffectAction = SKAction.sequence([
    .fadeIn(withDuration: 0.1),
    .wait(forDuration: 0.1),
    .fadeOut(withDuration: 0.3),
    .removeFromParent()
])

extension Effects {
    private func instructionLabel(_ text: String) -> SKLabelNode {
        let label = createLabel(x: Dimensions.widthHalf, y: Dimensions.heightHalf, size: Dimensions.height / 20, text: text)
        label.zPosition = ZIndices.labels
        return label
    }
    
    func startingInstructions() {
        #if os(iOS)
        let instruction1 = instructionLabel("Swipe to move.")
        #elseif os(macOS)
        let instruction1 = instructionLabel("Arrow/WASD keys\nto move.")
        #endif
        let instruction2 = instructionLabel("Survive &\ncollect stars!")
        instruction2.alpha = 0
        
        game.scene.addChild(instruction1)
        game.scene.addChild(instruction2)
        
        let labelBlink = SKAction.sequence([
            .fadeIn(withDuration: 0.3),
            .wait(forDuration: 0.4),
            .fadeOut(withDuration: 0.5),
            .removeFromParent(),
        ])
        
        instruction1.run(labelBlink)
        instruction2.run(.sequence([
            .wait(forDuration: 1.5),
            labelBlink
        ]))
    }

    private func presentHeroEffectLabel(text: String, size: CGFloat, duration: TimeInterval) {
        let effect = createLabel(x: 0, y: Dimensions.heightHalf / 24, size: size, text: text)
        effect.zPosition = ZIndices.labels
        
        game.hero.addChild(effect)
        effect.run(defaultEffectAction)
        effect.run(.moveBy(x: 0, y: Dimensions.height / 24, duration: duration))
    }

    func scoreIncreased() {
        presentHeroEffectLabel(
            text: "+1",
            size: Dimensions.height / 24,
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

    func superpowerGranted() {
        presentHeroEffectLabel(
            text: "wallbreaker\ngained",
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
