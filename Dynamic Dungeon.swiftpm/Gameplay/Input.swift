//
//  Input.swift
//  Dynamic Dungeon
//
//  Created by Vincent C. on 20/04/2017.
//  Copyright © 2017 StartDev. All rights reserved.
//

import SpriteKit

// MARK: Sliding Controls

extension Game {
    func slide(begin: CGPoint, end: CGPoint) {
        if !isInAction {
            let xDiff = end.x - begin.x
            let yDiff = end.y - begin.y
            let angle = Double(atan2(yDiff, xDiff))
            
            isInAction = true
            
            switch angle {
            case -(3 * .pi / 4) ..<    -(.pi / 4): /* Down  */
                tryMovement(
                    xShift: 0,
                    yShift: -GameParameters.squareSide
                )
            case     -(.pi / 4) ..<     (.pi / 4): /* Right */
                tryMovement(
                    xShift: GameParameters.squareSide,
                    yShift: 0
                )
            case      (.pi / 4) ..< (3 * .pi / 4): /* Up    */
                tryMovement(
                    xShift: 0,
                    yShift: GameParameters.squareSide
                )
            default: /* Left  */
                tryMovement(
                    xShift: -GameParameters.squareSide,
                    yShift: 0
                )
            }
        }
    }
}

// MARK: Handling Input

var previousInputPoint : CGPoint?

func inputBegan(touchPoint: CGPoint, game: Game) {
    previousInputPoint = touchPoint
}

func inputEnded(touchPoint: CGPoint, game: Game) {
    defer { previousInputPoint = nil }
    
    if let begin = previousInputPoint {
        game.slide(begin: begin, end: touchPoint)
    }
}

// MARK: Scenes

func slideWithKeys(xShift: CGFloat, yShift: CGFloat, game: Game) {
    if !game.isInAction {
        game.isInAction = true
        game.tryMovement(xShift: xShift, yShift: yShift)
    }
}
