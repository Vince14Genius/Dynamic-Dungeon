//
//  Tile.swift
//  
//
//  Created by Vincent C. on 5/10/23.
//

import SpriteKit

class Tile : SKNode {
    var node : SKSpriteNode
    var x    : Int
    var type : TileType
    
    init(type inputType: TileType, xCoordinate: (Int)) {
        type = inputType
        x    = xCoordinate
        
        switch type {
        case .path:
            node = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "tileRoad")))
            node.zPosition = ZIndices.tiles
        case .wall:
            node = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "tileWall")))
            node.zPosition = ZIndices.walls
        }
        
        super.init()
        
        node.size = CGSize(width: GameParameters.squareSide, height: GameParameters.squareSide)
        position  = CGPoint(x: CGFloat(xCoordinate - 1) * (GameParameters.squareSide) + (GameParameters.squareSide / 2), y: 0)
        
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func turnIntoPath() {
        type = .path
        node.texture = SKTexture(image: #imageLiteral(resourceName: "tileRoad"))
        node.zPosition = ZIndices.tiles
    }
    
    func turnIntoWall() {
        type = .wall
        node.texture = SKTexture(image: #imageLiteral(resourceName: "tileWall"))
        node.zPosition = ZIndices.walls
    }
}
