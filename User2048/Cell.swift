//
//  Cell.swift
//  User2048
//
//  Created by Miles Elvidge on 13/03/2017.
//  Copyright © 2017 Miles Elvidge. All rights reserved.
//

import Foundation
import SpriteKit

class Cell {
    var diameter: Int!
    var value: Int!
    var pos: Position!
    var isEmpty: Bool {
        return value == 0 ? true : false
    }
    var hasTransformed: Bool!
    
    init(position: Position, width: Int) {
        // Initilize cell varaiables
        pos = position
        value = 0
        diameter = width
        hasTransformed = false
    }
    
    func spawn(_ v: Int) {
        value = v
        print("Cell created at \(pos.str)")
    }
    
    func display() -> SKNode {
        // Display cell to the screen (for playable games or for best of generation in AI version)
        let node = SKNode()
        node.name = pos.str
        
        let x = (pos.x * diameter) + (diameter / 2)
        let y = (pos.y * diameter) + (diameter / 2)
        let rect = SKShapeNode(rectOf: CGSize(width: diameter, height: diameter))
        rect.position = CGPoint(x: x, y: -y)
        
        rect.strokeColor = SKColor.white
        rect.zPosition = 13
        
        let textNode = SKLabelNode()
        if(isEmpty) {
            rect.fillColor = SKColor.gray
        } else {
            let hue: CGFloat = CGFloat(value % 255) / 255
            rect.fillColor = SKColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
            
            textNode.fontName = "AvenirNext-Bold"
            textNode.text = "\(value)"
            textNode.fontColor = SKColor.white
            textNode.position = rect.position
            textNode.fontSize = 40
            textNode.zPosition = 14
        }
        
        // Remember, once returned to main, remove all old nodes and replace with new ones
        node.addChild(rect)
        node.addChild(textNode)
        return rect
    }
}
