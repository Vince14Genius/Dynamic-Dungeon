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
    private(set) var effects: Effects!
    
    let allTiles = SKNode()
    let hero = Hero()
    
    var isSuperpowerOn = false
    var combo = 0
    
    var previousRowNode: SKNode?
    var previousRowPool: [Tile]?
    var isInAction = false
    
    var rowsGenerated = 0
    
    init() {
        scene = .init(
            size: .init(
                width: Dimensions.width,
                height: Dimensions.height
            ),
            game: self
        )
        effects = .init(game: self)
        setup()
    }
}
