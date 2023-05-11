//
//  GameScene.swift
//  
//
//  Created by Vincent C. on 5/9/23.
//

import SpriteKit

class GameScene : SKScene {
    let game: Game
    
    init(size: CGSize, game: Game) {
        self.game = game
        super.init(size: size)
        scaleMode = .aspectFit
        
        createShadows()
        addChild(game.allTiles)
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
            inputBegan(touchPoint: touchPoint, game: game)
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touchPoint = touches.first?.location(in: self) else { return }
            inputEnded(touchPoint: touchPoint, game: game)
        }
        
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touchPoint = touches.first?.location(in: self) else { return }
            inputEnded(touchPoint: touchPoint, game: game)
        }
        
    }
#endif

#if os(macOS)
    // Mouse-based event handling
    extension GameScene {
        
        override func mouseDown(with event: NSEvent) {
            inputBegan(touchPoint: event.location(in: self), game: game)
        }
        
        override func mouseUp(with event: NSEvent) {
            inputEnded(touchPoint: event.location(in: self), game: game)
        }
        
        override func keyUp(with event: NSEvent) {
            switch event.keyCode {
            case keyCodeA:
                slideWithKeys(
                    xShift: -squareSide, yShift: 0, game: game)
            case keyCodeLeft:
                slideWithKeys(xShift: -squareSide, yShift: 0, game: game)
            case keyCodeD:
                slideWithKeys(xShift:  squareSide, yShift: 0, game: game)
            case keyCodeRight:
                slideWithKeys(xShift:  squareSide, yShift: 0, game: game)
            case keyCodeW:
                slideWithKeys(xShift: 0, yShift:  squareSide, game: game)
            case keyCodeUp:
                slideWithKeys(xShift: 0, yShift:  squareSide, game: game)
            case keyCodeS:
                slideWithKeys(xShift: 0, yShift: -squareSide, game: game)
            case keyCodeDown:
                slideWithKeys(xShift: 0, yShift: -squareSide, game: game)
            case keyCodeEsc:
                game.isPaused.toggle()
            default:
                game.isPaused.toggle()
            }
        }
    }
#endif
