//
//  DieFace.swift
//  Farkle
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

struct DieFace {
    var value: Int = 0
    var points: Int = 0
    var countThisRoll: Int = 0
    var scoringDie: Bool = false
    var unSelectedTexture: SKTexture = SKTexture()
    var selectedTexture: SKTexture = SKTexture()
    
    init(faceValue: Int, pointValue: Int, scoringDie: Bool) {
        self.value = faceValue
        self.points = pointValue
        self.scoringDie = scoringDie
    }
}
