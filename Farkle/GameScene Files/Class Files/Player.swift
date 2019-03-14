//
//  Player.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class Player {
    var name: String
    let nameLabel: SKLabelNode = SKLabelNode()
    let scoreLabel: SKLabelNode = SKLabelNode()
    
    var score: Int
    var currentRollScore: Int
    var hasScoringDice: Bool
    var isRolling: Bool
    var isSelectingDice: Bool
    var lastRoll: Bool
    var finished: Bool

    init(name: String, score: Int, currentRollScore: Int, hasScoringDice: Bool, isRolling: Bool, isSelectingDice: Bool, lastRoll: Bool, finished: Bool)
    {
        self.name = name
        self.score = score
        self.currentRollScore = currentRollScore
        self.hasScoringDice = hasScoringDice
        self.isRolling = isRolling
        self.isSelectingDice = isSelectingDice
        self.lastRoll = lastRoll
        self.finished = finished

    }
}

