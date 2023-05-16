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
        let currentRowNode = SKNode()
        var currentRowPool : [Tile] = []
        
        if
            let previousRowPool,
            rowsGenerated % 2 == 0
        {
            // MARK: Generate row that connects from previous paths
            var lastPathCount  = 0
            var pathsAvailable = [1, 2, 3, 4, 5, 6]
            
            for i in previousRowPool {
                if i.type == .path {
                    lastPathCount += 1
                    currentRowPool.append(Tile(type: .path, xCoordinate: i.x))
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
            
            if
                previousRowPool.count == 2,
                abs(previousRowPool[0].x - previousRowPool[1].x) > 2
            {
                // connect the paths if they are too far apart
                let lower = min(previousRowPool[0].x, previousRowPool[1].x)
                let upper = max(previousRowPool[0].x, previousRowPool[1].x)
                for i in lower + 1 ..< upper {
                    currentRowPool.append(Tile(type: .path, xCoordinate: i))
                }
            } else {
                // Add random path tiles
                for i in pathsAvailable {
                    if Int.random(in: 0 ..< 4) < lastPathCount {
                        currentRowPool.append(Tile(type: .path, xCoordinate: i))
                    }
                }
            }
        } else if let previousRowPool {
            // MARK: Generates paths that connect from previous paths
            var numberOfPaths = Int.random(in: 1 ..< 4)
            var pathsAvailable = [1, 2, 3, 4, 5, 6]
            
            for i in previousRowPool {
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
            
            if numberOfPaths > pathsAvailable.count { numberOfPaths = pathsAvailable.count }
            
            for _ in 1 ... numberOfPaths {
                let randomLocation = Int.random(in: 0 ..< pathsAvailable.count)
                let addingCoordinate = pathsAvailable[randomLocation]
                pathsAvailable.remove(at: randomLocation)
                
                currentRowPool.append(Tile(type: .path, xCoordinate: addingCoordinate))
            }
        } else {
            // MARK: Generate initial open rows
            for i in 1 ... 6 {
                currentRowPool.append(Tile(type: .path, xCoordinate: i))
            }
        }
        
        // MARK: Add star
        
        if
            rowsGenerated > 0,
            rowsGenerated % GameParameters.rowGenerationsNeededPerStar == 0
        {
            currentRowPool[Int.random(in: 0 ..< currentRowPool.count)].addChild(
                AddOn(type: .star, game: self)
            )
        }
        
        // MARK: Add walls
        
        var wallsAvailable = [1, 2, 3, 4, 5, 6]
        for i in currentRowPool {
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
            currentRowPool.append(Tile(type: .wall, xCoordinate: i))
        }
        
        // MARK: Finalize
        
        previousRowPool = currentRowPool
        
        for tile in currentRowPool {
            currentRowNode.addChild(tile)
        }
        
        if let last = previousRowNode {
            currentRowNode.position.y = last.position.y + GameParameters.squareSide
        }
        
        previousRowNode = currentRowNode
        rowsGenerated += 1
        
        allTiles.addChild(currentRowNode)
        allTiles.position.y = 0
    }
}
