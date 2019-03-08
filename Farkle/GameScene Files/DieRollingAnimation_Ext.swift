//
//  DieRolling_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 3/2/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {

}
    
    //MARK: ********** Roll Dice **********
 
    /*
    func rollDice(isComplete: (Bool) -> Void) {
        //getCurrentPlayer()
        removeSelectedDice(isComplete: handlerBlock)
        whatchaGot(isComplete: handlerBlock)
        //getDiceRoll()
        var randomX = CGFloat()
        var randomY = CGFloat()
        
        let getRandomPoints = SKAction.run {
            randomX = CGFloat(arc4random_uniform(5) + 5)
            randomY = CGFloat(arc4random_uniform(2) + 3)
        }
        //randomX = CGFloat(arc4random_uniform(5) + 5)
        //randomY = CGFloat(arc4random_uniform(2) + 3)
        
        //var moveAction = SKAction()
        var rollAction = SKAction()
        
        let Wait = SKAction.wait(forDuration: 0.75)
        
        if let RollAction = SKAction(named: "RollDice") {
            rollAction = RollAction
        }
        
        let FadeOut = SKAction.fadeAlpha(to:  0, duration: 0.75)
        let FadeIn = SKAction.fadeAlpha(to: 1, duration: 0.75)
        
       
        let SetFace = SKAction.run {
            //for die in self.currentDiceArray {
            self.setDieFace()
            //}
        }
        
        let RepositionDice = SKAction.run {
            self.repositionDice()
        }
        
        let randomPosition = SKAction.run {
            
            let randomPoint: CGPoint = CGPoint(x: randomX * 20, y: randomY * 10)
            
            self.currentDie.position = randomPoint
        }
        
        let moveAction = SKAction.run {
            for die in self.currentDiceArray {
                die.physicsBody?.isDynamic = true
                die.physicsBody?.pinned = false
                die.physicsBody?.allowsRotation = true
                
                die.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
                die.physicsBody?.applyTorque(3)
            }
        }
        
        let Group = SKAction.group([getRandomPoints, rollAction])
        let Group2 = SKAction.group([Group, randomPosition, moveAction, SetFace, Wait, FadeOut, RepositionDice, FadeIn])
        for die in currentDiceArray {
            die.run(Group2)
        }
        isComplete(true)
    }
    */
    
