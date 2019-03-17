//
//  DieRolling_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 3/2/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    func animateDice(die: Die, isComplete: (Bool) -> Void) {
        
        var randomX = CGFloat()
        var randomY = CGFloat()
        
        let getRandomPoints = SKAction.run {
            randomX = -CGFloat(arc4random_uniform(5) + 5)
            randomY = -CGFloat(arc4random_uniform(2) + 3)
        }
        
        var rollAction = SKAction()
        
        //let Wait = SKAction.wait(forDuration: 0.75)
        
        if let RollAction = SKAction(named: "RollDice") {
            rollAction = RollAction
        }
        
        let SetFace = SKAction.run {
            if die.selected {
                die.texture = die.currentFace.selectedTexture
            } else {
                die.texture = die.currentFace.unSelectedTexture
            }
        }
        
        let randomPosition = SKAction.run {
            
            let randomPoint: CGPoint = CGPoint(x: randomX * 20, y: randomY * 10)
            
            die.position = randomPoint
        }
        
        let moveAction = SKAction.run {
            die.physicsBody?.isDynamic = true
            die.physicsBody?.pinned = false
            die.physicsBody?.allowsRotation = true
            
            die.physicsBody?.applyImpulse(CGVector(dx: randomX * 2, dy: randomY * 2))
            die.physicsBody?.applyTorque(3)
        }
        
        let Group = SKAction.group([moveAction, rollAction])
        let seq = SKAction.sequence([getRandomPoints, randomPosition, Group, SetFace])

        die.run(seq)
        isComplete(true)
    }
    
    /*
    func moveSelectedDice(die: Die, isComplete: (Bool) -> Void) {
        let FadeOut = SKAction.fadeAlpha(to:  0, duration: 0.75)
        let FadeIn = SKAction.fadeAlpha(to: 1, duration: 0.75)
        let positionDice = SKAction.run {
            self.positionDice(isComplete: self.handlerBlock)
        }

        let selectedSeq = SKAction.sequence([FadeOut, positionDice, FadeIn])

        isComplete(true)
    }
    */
}

