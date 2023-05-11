//
//  Method.swift
//  Dynamic Dungeon
//
//  Created by Vincent C. on 20/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

extension Game {
    func generateTiles() {
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
                    if Int.random(in: 0 ..< 4) < lastPathCount {
                        thisCombo.append(Tile(type: .path, xCoordinate: i))
                    }
                }
            }
        } else { //Generates paths that connect from previous paths
            var numberOfPaths = Int.random(in: 1 ..< 4)
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
                let randomLocation = Int.random(in: 0 ..< pathsAvailable.count)
                let addingCoordinate = pathsAvailable[randomLocation]
                pathsAvailable.remove(at: randomLocation)
                
                thisCombo.append(Tile(type: .path, xCoordinate: addingCoordinate))
            }
        }
        
        //Add addons
        
        if
            rowsGenerated > 0,
            rowsGenerated % GameParameters.rowGenerationsNeededPerStar == 0
        {
            thisCombo[Int.random(in: 0 ..< thisCombo.count)].addChild(
                AddOn(type: .star, game: self)
            )
        }
        
        if rowsGenerated != 0 {
            for child in allTiles.children {
                for i in child.children {
                    if
                        let tile = i as? Tile,
                        tile.type == .path,
                        Double.random(in: 0..<1) < stunAttackChance
                    {
                        tile.addChild(
                            AddOn(
                                type: .specialAttackWindup,
                                game: self
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
            row.position.y = last.position.y + GameParameters.squareSide
        }
        
        lastRow = row
        rowsGenerated += 1
        
        allTiles.addChild(row)
        allTiles.position.y = 0
    }
}
