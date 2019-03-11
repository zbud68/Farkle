//
//  DieFaces.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class DieFaces_copy {
    var value: Int = 0
    var points: Int = 0
    var countThisRoll: Int = 0
    var scoringDie: Bool = false
    var die: Die_copy = Die_copy()
   
    init(value: Int, points: Int, scoringDie: Bool) {
        self.value = value
        self.points = points
        self.scoringDie = scoringDie
    }
}
