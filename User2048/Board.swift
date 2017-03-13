//
//  Board.swift
//  User2048
//
//  Created by Miles Elvidge on 13/03/2017.
//  Copyright © 2017 Miles Elvidge. All rights reserved.
//


import Foundation
import SpriteKit

class Board {
    let DIMENTION: Int = 4 // Specifies n * n board, where n is the dimention
    
    var score = 0
    var moveCount = 0
    var attempt = 0
    var turn = 0
    var board: [[Cell]]!
    var isAlive = true
    // var moves: [Int]! // for AI implementation
    
    init(w: Int) {
        // Initilize two dimentional array for the board grid
        board = [[Cell]]()
        for y in 0..<DIMENTION {
            var row = [Cell]()
            for x in 0..<DIMENTION {
                let c = Cell(position: Position(x, y), width: w/DIMENTION)
                row.append(c)
            }
            board.append(row)
        }
        
        // moves = [Int]()
        turn = 0
        score = 0
        moveCount = 0
        attempt = 0
        
        // Spawn initial two starting cells
        self.spawnCell()
        self.spawnCell()
    }
    
    func move(direction: Int) {
        // Direction = {0, 1, 2, 3}
        // Where 0 = UP, 1 = RIGHT, 2 = DOWN, 3 = LEFT
        var hasMoved = false
        moveCount = 0
        for _ in 0..<DIMENTION {
            var p = Position(0, 0)
            var p1 = Position(1, 0)
            switch(direction) {
            case 0:
                for y in 1..<DIMENTION {
                    for x in 0..<DIMENTION {
                        p = Position(x, y)
                        p1 = Position(x, y-1)
                        if(canMove(p, p1)) {
                            merge(p, p1)
                            hasMoved = true
                        }
                    }
                }
            case 1:
                for x in (0..<DIMENTION-1).reversed() {
                    for y in 0..<DIMENTION {
                        p = Position(x, y)
                        p1 = Position(x+1, y)
                        if(canMove(p, p1)) {
                            merge(p, p1)
                            hasMoved = true
                        }
                    }
                }
            case 2:
                for y in (0..<DIMENTION-1).reversed() {
                    for x in 0..<DIMENTION {
                        p = Position(x, y)
                        p1 = Position(x, y+1)
                        if(canMove(p, p1)) {
                            merge(p, p1)
                            hasMoved = true
                        }
                    }
                }
            case 3:
                for x in 1..<DIMENTION {
                    for y in 0..<DIMENTION {
                        p = Position(x, y)
                        p1 = Position(x-1, y)
                        if(canMove(p, p1)) {
                            merge(p, p1)
                            hasMoved = true
                        }
                    }
                }
            default: print("Error in logic...")
            }
        }
        
        if(hasMoved) { spawnCell() }
        // Reset the transformed variable
        for y in 0..<DIMENTION {
            for x in 0..<DIMENTION {
                board[y][x].hasTransformed = false
            }
        }
        
        // TODO: in AI implmentation, make so that this code only runs if the procedure isn't forced
        // moves.append(direction)
        // attempts = 0
        // spawnCell()
        
        //print("Score: \(score)")
        isAlive = checkAlive()
        if(!isAlive) {
            //print("Game Over!")
        }
    }
    
    func merge(_ p: Position, _ p1: Position) {
        // Swap two cells on the 2D array
        let temp = board[p1.y][p1.x]
        board[p1.y][p1.x].value = board[p1.y][p1.x].value + board[p.y][p.x].value
        board[p.y][p.x].value = 0
        board[p.y][p.x].hasTransformed = false
        if(temp.value != 0) {
            board[p1.y][p1.x].hasTransformed = true
            score += board[p1.y][p1.x].value
        }
        
        //print("Cell at ",p.str," moved to ",p1.str)
        moveCount += 1
    }
    
    func canMove(_ p: Position, _ p1: Position) -> Bool {
        if(!board[p.y][p.x].isEmpty) {
            // Current cell is occupied
            if(board[p1.y][p1.x].isEmpty) {
                // Destination is empty
                return true
            } else if(canMerge(p, p1) && !board[p.y][p.x].hasTransformed && !board[p1.y][p1.x].hasTransformed) { return true }
        }
        
        return false
    }
    
    func canMerge(_ p: Position, _ p1: Position) -> Bool {
        // this function assumes both positions on the board are occupied
        return board[p.y][p.x].value == board[p1.y][p1.x].value
    }
    
    func spawnCell() {
        // Generate cell at random position
        var x: Int = 0
        var y: Int = 0
        repeat {
            x = Int(arc4random_uniform(UInt32(DIMENTION)))
            y = Int(arc4random_uniform(UInt32(DIMENTION)))
        } while(!board[y][x].isEmpty)
        
        let r = drand48()
        let v = r > 0.9 ? 4 : 2 // occasional starting value of 4, with probability of 0.9
        
        board[y][x].spawn(v)
    }
    
    func display() -> [SKNode] {
        var nodes = [SKNode]()
        for y in 0..<DIMENTION {
            for x in 0..<DIMENTION {
                nodes.append(board[y][x].display())
            }
        }
        return nodes
    }
    
    func checkAlive() -> Bool {
        if(attempt > 10) { return false }
        var p = Position(0, 0)
        var p1 = Position(1, 0)
        for direction in 0...3 {
            switch(direction) {
            case 0:
                for y in 1..<DIMENTION {
                    for x in 0..<DIMENTION {
                        p = Position(x, y)
                        p1 = Position(x, y-1)
                        if(canMove(p, p1)) {
                            return true
                        }
                    }
                }
            case 1:
                for x in (0..<DIMENTION-1).reversed() {
                    for y in 0..<DIMENTION {
                        p = Position(x, y)
                        p1 = Position(x+1, y)
                        if(canMove(p, p1)) {
                            merge(p, p1)
                            return true
                        }
                    }
                }
            case 2:
                for y in (0..<DIMENTION-1).reversed() {
                    for x in 0..<DIMENTION {
                        p = Position(x, y)
                        p1 = Position(x, y+1)
                        if(canMove(p, p1)) {
                            merge(p, p1)
                            return true
                        }
                    }
                }
            case 3:
                for x in 1..<DIMENTION {
                    for y in 0..<DIMENTION {
                        p = Position(x, y)
                        p1 = Position(x-1, y)
                        if(canMove(p, p1)) {
                            merge(p, p1)
                            return true
                        }
                    }
                }
            default: print("Error in logic...")
            }
        }
        
        return false
    }
}
