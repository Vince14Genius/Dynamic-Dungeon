//
//  Game.swift
//  
//
//  Created by Vincent C. on 5/9/23.
//

import Foundation
import SpriteKit

class Game: ObservableObject {
    @Published var score = 0
    @Published var isPaused = false {
        didSet {
            scene.isPaused = isPaused
        }
    }
    @Published var isGameOver = false
    
    private(set) var scene: GameScene!
    let allTiles = SKNode()
    let hero = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "hero")))
    
    init() {
        scene = .init(size: .init(width: width, height: height), game: self)
    }
}
