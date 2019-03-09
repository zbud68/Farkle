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
    var faceValue: Int = Int()
    var pointValue: Int = Int()
    var scoringDie: Bool = false
    var diePosition: CGPoint = CGPoint()

}
