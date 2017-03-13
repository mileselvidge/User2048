//
//  Main.swift
//  User2048
//
//  Created by Miles Elvidge on 13/03/2017.
//  Copyright © 2017 Miles Elvidge. All rights reserved.
//

import SpriteKit
import GameplayKit

class Main: SKScene {
    var b: Board! // Gameboard
    
    override func didMove(to view: SKView) {
        // Setup
        b = Board(w: Int(self.frame.height))
        for node in b.display() {
            self.addChild(node)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called per frame
    }
    
    override func keyDown(with event: NSEvent) {
        // Key pressed, look to see if the key corresponds to a relevent direction
        if(b.isAlive) {
            switch(event.keyCode) {
            case 123: b.move(direction: 3)
            case 124: b.move(direction: 1)
            case 125: b.move(direction: 2)
            case 126: b.move(direction: 0)
            default: print("Error: Key does not correspond to action!")
            }
            
            // Display board
            self.removeAllChildren()
            for node in b.display() {
                self.addChild(node)
            }
        }
    }
}
