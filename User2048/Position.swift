//
//  Position.swift
//  User2048
//
//  Created by Miles Elvidge on 13/03/2017.
//  Copyright © 2017 Miles Elvidge. All rights reserved.
//

import Foundation

struct Position {
    var x: Int
    var y: Int
    var str: String {
        return "[\(x), \(y)]"
    }
    
    init(_ x_: Int, _ y_: Int) {
        x = x_;
        y = y_;
    }
    
}
