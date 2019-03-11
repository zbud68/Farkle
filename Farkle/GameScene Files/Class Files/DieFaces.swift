//
//  DieFaces.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

struct DieFaces {
    var faceValue: Int = 0
    var pointValue: Int = 0
    var countThisRoll: Int = 0
    var scoringDie: Bool = false
    
    init(value: Int, points: Int, scoringDie: Bool) {
        self.faceValue = value
        self.pointValue = points
        self.scoringDie = scoringDie
    }
}
