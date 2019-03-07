//
//  DieRolling_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 3/2/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
    
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
    
    func setDieFace() {
        for die in currentDiceArray {
            die.faceValue = Int(arc4random_uniform(6)+1)
            print(die.faceValue)
            switch die.faceValue {
            case 1:
                die.texture = GameConstants.Textures.Die1
            case 2:
                die.texture = GameConstants.Textures.Die2
            case 3:
                die.texture = GameConstants.Textures.Die3
            case 4:
                die.texture = GameConstants.Textures.Die4
            case 5:
                die.texture = GameConstants.Textures.Die5
            case 6:
                die.texture = GameConstants.Textures.Die6
            default:
                break
            }
        }
    }
    func repositionDice() {
        for die in currentDiceArray {
            die.zRotation = 0
            die.zPosition = GameConstants.ZPositions.Dice
            die.size = GameConstants.Sizes.Dice
            die.physicsBody?.isDynamic = true
            
            switch die.name {
            case "Die 1":
                die1.position = CGPoint(x: -(gameTable.size.width / 7), y: gameTable.frame.minY + 100)
            case "Die 2":
                die2.position = CGPoint(x: die1.position.x + die2.size.width, y: gameTable.frame.minY + 100)
            case "Die 3":
                die3.position = CGPoint(x: die2.position.x + die3.size.width, y: gameTable.frame.minY + 100)
            case "Die 4":
                die4.position = CGPoint(x: die3.position.x + die4.size.width, y: gameTable.frame.minY + 100)
            case "Die 5":
                die5.position = CGPoint(x: die4.position.x + die5.size.width, y: gameTable.frame.minY + 100)
            case "Die 6":
                die6.position = CGPoint(x: die5.position.x + die6.size.width, y: gameTable.frame.minY + 100)
            default:
                break
            }
        }
    }
}
