//
//  Input.swift
//  Dynamic Dungeon
//
//  Created by Vincent C. on 20/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

extension Game {
    enum MoveDirection {
        case left, right, up, down
    }
    
    func moveHero(_ direction: MoveDirection) {
        guard !isInAction else { return }
        isInAction = true
        
        switch direction {
        case .left:
            tryMovement(
                xShift: -GameParameters.squareSide,
                yShift: 0
            )
        case .right:
            tryMovement(
                xShift: GameParameters.squareSide,
                yShift: 0
            )
        case .up:
            tryMovement(
                xShift: 0,
                yShift: GameParameters.squareSide
            )
        case .down:
            tryMovement(
                xShift: 0,
                yShift: -GameParameters.squareSide
            )
        }
    }
}


// MARK: Sliding Controls

extension Game.MoveDirection {
    static func fromVector(begin: CGPoint, end: CGPoint) -> Self {
        let xDiff = end.x - begin.x
        let yDiff = end.y - begin.y
        let angle = Double(atan2(yDiff, xDiff))
        
        switch angle {
        case -(3 * .pi / 4) ..<    -(.pi / 4):
            return .down
        case     -(.pi / 4) ..<     (.pi / 4):
            return .right
        case      (.pi / 4) ..< (3 * .pi / 4):
            return .up
        default:
            return .left
        }
    }
}

// MARK: Handling Touch Input

var previousInputPoint : CGPoint?

func inputBegan(touchPoint: CGPoint, game: Game) {
    previousInputPoint = touchPoint
}

func inputEnded(touchPoint: CGPoint, game: Game) {
    defer { previousInputPoint = nil }
    
    if let begin = previousInputPoint {
        game.moveHero(.fromVector(begin: begin, end: touchPoint))
    }
}
