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
    var selectedDieTexture: SKTexture = SKTexture()
    var unSelectedDieTexture: SKTexture = SKTexture()
    var currentDieTexture: SKTexture = SKTexture()
    var faceValue: Int = Int()
    //var pointValue: Int = Int()
    var count: Int = Int()

}
