//
//  Effects.swift
//  Dynamic Dungeon
//
//  Created by Vincent Cai [STUDENT] on 20/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

class Effects {
    unowned var game: Game
    init(game: Game) {
        self.game = game
    }
}

private let defaultEffectAction = SKAction.sequence([
    .fadeIn(withDuration: 0.1),
    .wait(forDuration: 0.1),
    .fadeOut(withDuration: 0.3),
    .removeFromParent()
])

extension Effects {
    func startingInstructions() {
        #if os(iOS)
        let effect = createLabel(x: Dimensions.widthHalf, y: Dimensions.heightHalf, size: Dimensions.height / 20, text: "Swipe to move.")
        #elseif os(macOS)
        let effect = createLabel(x: Dimensions.widthHalf, y: Dimensions.heightHalf, size: Dimensions.height / 20, text: "Arrow/WASD keys\nto move.")
        #endif
        effect.zPosition = ZIndices.buttons
        game.scene.addChild(effect)
        
        effect.run(.sequence([
            .fadeIn(withDuration: 0.5),
            .wait(forDuration: 0.1),
            .fadeOut(withDuration: 0.5),
            .removeFromParent(),
        ]))
    }

    private func presentHeroEffectLabel(text: String, size: CGFloat, duration: TimeInterval) {
        let effect = createLabel(x: 0, y: Dimensions.heightHalf / 24, size: size, text: text)
        effect.zPosition = ZIndices.buttons
        
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
