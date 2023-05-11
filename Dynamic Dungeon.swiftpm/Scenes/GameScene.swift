//
//  GameScene.swift
//  
//
//  Created by Vincent C. on 5/9/23.
//

import SpriteKit

class GameScene : SKScene {
    let gameState: GameState
    
    init(size: CGSize, gameState: GameState) {
        self.gameState = gameState
        super.init(size: size)
        scaleMode = .aspectFit
        
        createShadows(scene: self)
        addChild(gameState.allTiles)
        gameSetup(gameState: gameState)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if os(iOS)
    // Touch-based event handling
    extension GameScene {
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touchPoint = touches.first?.location(in: self) else { return }
            inputBegan(touchPoint: touchPoint, gameState: gameState)
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touchPoint = touches.first?.location(in: self) else { return }
            inputEnded(touchPoint: touchPoint, gameState: gameState)
        }
        
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touchPoint = touches.first?.location(in: self) else { return }
            inputEnded(touchPoint: touchPoint, gameState: gameState)
        }
        
    }
#endif

#if os(macOS)
    // Mouse-based event handling
    extension GameScene {
        
        override func mouseDown(with event: NSEvent) {
            inputBegan(touchPoint: event.location(in: self), gameState: gameState)
        }
        
        override func mouseUp(with event: NSEvent) {
            inputEnded(touchPoint: event.location(in: self), gameState: gameState)
        }
        
        override func keyUp(with event: NSEvent) {
            switch event.keyCode {
            case keyCodeA:
                slideWithKeys(
                    xShift: -squareSide, yShift: 0, gameState: gameState)
            case keyCodeLeft:
                slideWithKeys(xShift: -squareSide, yShift: 0, gameState: gameState)
            case keyCodeD:
                slideWithKeys(xShift:  squareSide, yShift: 0, gameState: gameState)
            case keyCodeRight:
                slideWithKeys(xShift:  squareSide, yShift: 0, gameState: gameState)
            case keyCodeW:
                slideWithKeys(xShift: 0, yShift:  squareSide, gameState: gameState)
            case keyCodeUp:
                slideWithKeys(xShift: 0, yShift:  squareSide, gameState: gameState)
            case keyCodeS:
                slideWithKeys(xShift: 0, yShift: -squareSide, gameState: gameState)
            case keyCodeDown:
                slideWithKeys(xShift: 0, yShift: -squareSide, gameState: gameState)
            case keyCodeEsc:
                gameState.isPaused.toggle()
            default:
                gameState.isPaused.toggle()
            }
        }
    }
#endif
