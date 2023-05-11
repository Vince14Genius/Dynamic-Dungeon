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
            let childShadow = SKSpriteNode(texture: SKTexture(imageNamed: "edgeOfHell"), size: CGSize(width: Dimensions.width, height: Dimensions.width * 0.25))
            childShadow.position  = CGPoint(x: Dimensions.widthHalf, y: Dimensions.heightHalf + Dimensions.widthHalf - Dimensions.width * CGFloat(i))
            childShadow.zPosition = ZIndices.shadows
            childShadow.zRotation = CGFloat(.pi * Double(i))
            shadows.addChild(childShadow)
            
            let blackFrame = SKShapeNode(rect: CGRect(x: 0, y: 0, width: Dimensions.width, height: 100))
            blackFrame.position = CGPoint(x: 0, y: Dimensions.heightHalf + Dimensions.widthHalf + childShadow.size.height / 2 - ((Dimensions.width + childShadow.size.height + 100) * CGFloat(i)))
            blackFrame.fillColor   = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            blackFrame.strokeColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            blackFrame.zPosition   = ZIndices.shadows
            shadows.addChild(blackFrame)
        }
    }
}
