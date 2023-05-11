//
//  Effects.swift
//  Dynamic Dungeon
//
//  Created by Vincent Cai [STUDENT] on 20/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

func effectGameStart(scene: SKScene) {
    let effect = createLabel(x: widthHalf, y: heightHalf, size: height / 20, text: "Arrow/WASD keys\nto move.")
    effect.zPosition = zOfButtons
    scene.addChild(effect)
    
    effect.run(.sequence([
        .fadeIn(withDuration: 0.5),
        .wait(forDuration: 0.1),
        .fadeOut(withDuration: 0.5),
        .removeFromParent(),
    ]))
}

private let defaultEffectAction = SKAction.sequence([
    .fadeIn(withDuration: 0.1),
    .wait(forDuration: 0.1),
    .fadeOut(withDuration: 0.3),
    .removeFromParent()
])

func effectAddScore(gameState: GameState) {
    let effect = createLabel(x: 0, y: heightHalf / 24, size: height / 24, text: "+1")
    effect.zPosition = zOfButtons
    
    gameState.hero.addChild(effect)
    effect.run(defaultEffectAction)
    effect.run(.moveBy(x: 0, y: height / 24, duration: 0.5))
}

func effectStunned(gameState: GameState) {
    let effect = createLabel(x: 0, y: heightHalf / 24, size: height / 24, text: "Stunned")
    effect.zPosition = zOfButtons
    
    gameState.hero.addChild(effect)
    effect.run(defaultEffectAction)
    effect.run(.moveBy(x: 0, y: height / 24, duration: 0.5))
}

func effectSuperpowerGranted(gameState: GameState) {
    let effect = createLabel(x: 0, y: heightHalf / 24, size: height / 32, text: "wallbreaker\ngained")
    effect.zPosition = zOfButtons
    
    gameState.hero.addChild(effect)
    effect.run(defaultEffectAction)
    effect.run(.moveBy(x: 0, y: height / 24, duration: 0.3))
}

func effectSuperpowerUsed(gameState: GameState) {
    let effect = createLabel(x: 0, y: heightHalf / 24, size: height / 36, text: "wallbreaker\nused")
    effect.zPosition = zOfButtons
    
    gameState.hero.addChild(effect)
    effect.run(defaultEffectAction)
    effect.run(.moveBy(x: 0, y: height / 24, duration: 0.3))
}
