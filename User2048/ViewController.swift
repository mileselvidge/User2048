//
//  ViewController.swift
//  User2048
//
//  Created by Miles Elvidge on 13/03/2017.
//  Copyright © 2017 Miles Elvidge. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {
    
    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Main") {
                // Set the scale mode to scale to fit the window
                scene.anchorPoint = CGPoint(x: 0, y: 1)
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

