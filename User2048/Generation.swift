//
//  Generation.swift
//  User2048
//
//  Created by Miles Elvidge on 13/03/2017.
//  Copyright © 2017 Miles Elvidge. All rights reserved.
//

import Foundation

class Generation {
    let SIZE = 10 // Generation Size
    var highscore = 0
    var allhighscore = 0
    var gen = 0
    var finishedPlaying = false
    var DNA: [[Int]]!
    var population: [Board]!
    
    init() {
        DNA = [[Int]]()
        population = [Board]()
        startGeneration()
    }
    
    func canContinue() -> Bool {
        for i in 0..<SIZE {
            if(population[i].isAlive) {
                return true
            }
        }
        return false
    }
    
    func displayResults() {
        print("Generation ",gen," finished playing!")
        var i = 1
        highscore = 0
        for b in population {
            print("Board #\(i) : \(b.score)")
            if(b.score > highscore) {
                highscore = b.score
                b.display()
            }
            i += 1
        }
        
        print("Highscore: ",highscore)
        print("All-time best: ",allhighscore)
        finishedPlaying = true
        
    }
}
