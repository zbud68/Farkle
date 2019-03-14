//
//  Die.swift
//  Farkle
//
//  Created by Mark Davis on 2/22/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class Die: SKSpriteNode {
    
    var selected: Bool = false
    var selectable: Bool = true
    var diePosition: CGPoint = CGPoint()
    var previousPosition: CGPoint = CGPoint()
    var currentFace: DieFace = DieFace(faceValue: 0, pointValue: 0, scoringDie: false)
}
