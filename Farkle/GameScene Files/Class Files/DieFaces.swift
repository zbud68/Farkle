//
//  DieFaces.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class DieFaces {
    var faceName: String
    var faceValue: Int
    var pointValue: Int
    var countThisRoll: Int
    var scoringDie: Bool
    
    init(name: String, faceValue: Int, pointValue: Int, countThisRoll: Int, scoringDie: Bool)
    {
        self.faceName = name
        self.faceValue = faceValue
        self.pointValue = pointValue
        self.countThisRoll = countThisRoll
        self.scoringDie = false
    }
}
