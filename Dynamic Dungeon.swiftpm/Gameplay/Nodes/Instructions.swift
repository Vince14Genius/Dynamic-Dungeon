//
//  Instructions.swift
//  
//
//  Created by Vincent C. on 7/11/23.
//

import SpriteKit

extension Effects {
    private func instructionLabel(_ text: String) -> SKLabelNode {
        let label = Effects.createLabel(x: Dimensions.widthHalf, y: Dimensions.heightHalf, size: Dimensions.height / 20, text: text)
        label.zPosition = ZIndices.labels
        return label
    }
    
    func startingInstructions() {
        let instruction1: SKLabelNode
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            instruction1 = instructionLabel("Swipe or WASD keys\nto move.")
        case .mac:
            instruction1 = instructionLabel("WASD keys\nto move.")
        default:
            instruction1 = instructionLabel("Swipe to move.")
        }
        
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
            .wait(forDuration: 1.4),
            labelBlink
        ]))
    }
}
