//
//  Basics.swift
//  Dynamic Dungeon
//
//  Created by Vincent Cai [STUDENT] on 17/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

enum TileType {
    case path
    case wall
}

enum AddonType {
    case star
    case litStar
    case specialAttackWindup
    case specialAttack
    case wallAttackWindup
}

func createLabel(x: CGFloat, y: CGFloat, size: CGFloat, text: String) -> SKLabelNode {
    let node = SKLabelNode(fontNamed: "AvenirNext-Regular")
    node.color = #colorLiteral(red: 0.474509805440903, green: 0.839215695858002, blue: 0.976470589637756, alpha: 1.0)
    node.horizontalAlignmentMode = .center
    node.verticalAlignmentMode = .center
    node.numberOfLines = 0
    
    node.position  = CGPoint(x: x, y: y)
    node.fontSize  = size
    node.text      = text
    node.zPosition = ZIndices.buttons
    return node
}
