//
//  Visuals.swift
//  
//
//  Created by Vincent C. on 5/10/23.
//

import SpriteKit

extension GameScene {
    func createShadows() {
        let shadows = SKNode()
        addChild(shadows)
        
        for i in 0 ... 1 {
            let shadowWidth = Dimensions.width
            let shadowHeight = Dimensions.width * 0.25
            let blackFrameHeight = 100.0
            
            let childShadow = SKSpriteNode(
                texture: SKTexture(imageNamed: "edgeOfHell"),
                size: CGSize(width: shadowWidth, height: shadowHeight)
            )
            
            childShadow.position = .init(
                x: Dimensions.widthHalf,
                y: Dimensions.height - shadowHeight / 2 - (Dimensions.height - shadowHeight) * CGFloat(i)
            )
            childShadow.zPosition = ZIndices.shadows
            childShadow.zRotation = CGFloat(.pi * Double(i))
            shadows.addChild(childShadow)
            
            let blackFrame = SKShapeNode(rect: CGRect(x: 0, y: 0, width: Dimensions.width, height: blackFrameHeight))
            blackFrame.position = CGPoint(
                x: 0,
                y: -blackFrameHeight + (Dimensions.height + blackFrameHeight * 2) * CGFloat(i)
            )
            blackFrame.fillColor   = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            blackFrame.strokeColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            blackFrame.zPosition   = ZIndices.shadows
            shadows.addChild(blackFrame)
        }
    }
}
