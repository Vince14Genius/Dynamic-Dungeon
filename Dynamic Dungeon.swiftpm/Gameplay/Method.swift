//
//  Method.swift
//  Dynamic Dungeon
//
//  Created by Vincent Cai [STUDENT] on 20/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

// MARK: In-Game Methods

var rowsGenerated = 0
var speedDuration = finalSpeedDuration + (initialSpeedDuration - finalSpeedDuration) / (Double(powf(Float(1 + speedIncreaseRateBase), Float(Double(rowsGenerated) * speedIncreaseRatePower))))

var lastRow   : SKNode?
var lastCombo : [Tile]?

func generateTiles(game: Game) {
    let row = SKNode()
    var thisCombo : [Tile] = []
    
    if rowsGenerated % 2 == 0 {
        if lastCombo == nil { //Generate open first row
            for i in 1 ... 6 {
                thisCombo.append(Tile(type: .path, xCoordinate: i))
            }
        } else { //Generate row that connects from previous paths
            var lastPathCount  = 0
            var pathsAvailable = [1, 2, 3, 4, 5, 6]
            
            for i in lastCombo! {
                if i.type == .path {
                    lastPathCount += 1
                    thisCombo.append(Tile(type: .path, xCoordinate: i.x))
                    var removeIndex : Int?
                    
                    for j in 0 ..< pathsAvailable.count {
                        if i.x == pathsAvailable[j] {
                            removeIndex = j
                        }
                    }
                    
                    if let x = removeIndex {
                        pathsAvailable.remove(at: x)
                    }
                }
            }
            
            for i in pathsAvailable {
                if Int(arc4random() % 4) < lastPathCount {
                    thisCombo.append(Tile(type: .path, xCoordinate: i))
                }
            }
        }
    } else { //Generates paths that connect from previous paths
        var numberOfPaths = Int(arc4random() % 3) + 1
        var pathsAvailable = [1, 2, 3, 4, 5, 6]
        
        for i in lastCombo! {
            if i.type == .wall {
                var removeIndex : Int?
                
                for j in 0 ..< pathsAvailable.count {
                    if i.x == pathsAvailable[j] {
                        removeIndex = j
                    }
                }
                
                if let x = removeIndex {
                    pathsAvailable.remove(at: x)
                }
            }
        }
        
        if numberOfPaths > pathsAvailable.count {numberOfPaths = pathsAvailable.count}
        
        for _ in 1 ... numberOfPaths {
            let randomLocation = Int(arc4random() % UInt32(pathsAvailable.count))
            let addingCoordinate = pathsAvailable[randomLocation]
            pathsAvailable.remove(at: randomLocation)
            
            thisCombo.append(Tile(type: .path, xCoordinate: addingCoordinate))
        }
    }
    
    //Add addons
    
    if (rowsGenerated % 3 == 0) && (rowsGenerated != 0) {
        thisCombo[Int(arc4random() % UInt32(thisCombo.count))].addChild(
            AddOn(type: .star, game: game)
        )
    }
    
    if rowsGenerated != 0 {
        for child in game.allTiles.children {
            for i in child.children {
                if
                    let tile = i as? Tile,
                    tile.type == .path,
                    arc4random() % 16 == 0
                {
                    tile.addChild(
                        AddOn(
                            type: .specialAttackWindup,
                            game: game
                        )
                    )
                }
            }
        }
    }
    
    //Add walls
    
    var wallsAvailable = [1, 2, 3, 4, 5, 6]
    for i in thisCombo {
        var removeIndex : Int?
        
        for j in 0 ..< wallsAvailable.count {
            if i.x == wallsAvailable[j] {
                removeIndex = j
            }
        }
        
        if let x = removeIndex {
            wallsAvailable.remove(at: x)
        }
    }
    
    for i in wallsAvailable {
        thisCombo.append(Tile(type: .wall, xCoordinate: i))
    }
    
    //Finalize
    
    lastCombo = thisCombo
    
    for tile in thisCombo {
        row.addChild(tile)
    }
    
    if let last = lastRow {
        row.position.y = last.position.y + squareSide
    }
    
    lastRow   = row
    rowsGenerated += 1
    
    game.allTiles.addChild(row)
    game.allTiles.position.y = 0
}

func createShadows(scene: SKScene) {
    let shadows = SKNode()
    scene.addChild(shadows)
    
    for i in 0 ... 1 {
        let childShadow = SKSpriteNode(texture: SKTexture(imageNamed: "edgeOfHell"), size: CGSize(width: width, height: width * 0.25))
        childShadow.position  = CGPoint(x: widthHalf, y: heightHalf + widthHalf - width * CGFloat(i))
        childShadow.zPosition = zOfShadows
        childShadow.zRotation = CGFloat(.pi * Double(i))
        shadows.addChild(childShadow)
        
        let blackFrame = SKShapeNode(rect: CGRect(x: 0, y: 0, width: width, height: 100))
        blackFrame.position = CGPoint(x: 0, y: heightHalf + widthHalf + childShadow.size.height / 2 - ((width + childShadow.size.height + 100) * CGFloat(i)))
        blackFrame.fillColor   = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        blackFrame.strokeColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        blackFrame.zPosition   = zOfShadows
        shadows.addChild(blackFrame)
    }
}

// MARK: Special Modes

var superpowerOn = false
var combo        = 0

func testForSuperpower(game: Game) {
    combo += 1
    if combo >= 4 {
        if !superpowerOn {
            effectSuperpowerGranted(game: game)
        }
        superpowerOn = true
        game.hero.texture = SKTexture(imageNamed: "heroSwift")
    }
}

func superpowerUse(game: Game) -> Bool {
    let superpowerWasOn = superpowerOn
    if superpowerOn {
        effectSuperpowerUsed(game: game)
    }
    superpowerOn = false
    combo = 0
    game.hero.texture = SKTexture(imageNamed: "hero")
    return superpowerWasOn
}

func superpowerOff(game: Game) {
    superpowerOn = false
    combo = 0
    game.hero.texture = SKTexture(imageNamed: "hero")
}
