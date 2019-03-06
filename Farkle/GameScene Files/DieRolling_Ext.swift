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
 
    func rollDice(isComplete: (Bool) -> Void) {
        removeSelectedDice(isComplete: handlerBlock)
        getDiceRoll()
        var randomX = CGFloat()
        var randomY = CGFloat()
        
        randomX = CGFloat(arc4random_uniform(5) + 5)
        randomY = CGFloat(arc4random_uniform(2) + 3)
        
        var moveAction = SKAction()
        var rollAction = SKAction()
        
        let Wait = SKAction.wait(forDuration: 0.75)
        
        if let RollAction = SKAction(named: "RollDice") {
            rollAction = RollAction
        }
        
        let FadeOut = SKAction.fadeAlpha(to:  0, duration: 0.75)
        let FadeIn = SKAction.fadeAlpha(to: 1, duration: 0.75)
        
        let SetFace = SKAction.run {
            for die in self.currentDice {
                self.setDieFace(die: die)
            }
        }
        
        let RepositionDice = SKAction.run {
            self.repositionDice()
        }
        
        let randomPosition = SKAction.run {
            
            let randomPoint: CGPoint = CGPoint(x: randomX * 20, y: randomY * 10)
            
            self.currentDie.position = randomPoint
        }
        
        moveAction = SKAction.run {
            
            self.currentDie.physicsBody?.isDynamic = true
            self.currentDie.physicsBody?.pinned = false
            self.currentDie.physicsBody?.allowsRotation = true
            
            self.currentDie.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
            self.currentDie.physicsBody?.applyTorque(3)
        }
        
        let Group = SKAction.group([rollAction])
        let Seq = SKAction.sequence([Group, randomPosition, moveAction, SetFace, Wait, FadeOut, RepositionDice, FadeIn])
        
        for die in currentDiceArray {
            currentDie = die
            die.run(Seq)
            die.run(SetFace)
        }
        isComplete(true)
    }
    
    func setDieFace(die: Die) {
        switch die.faceValue{
        case 1:
            self.currentDie.texture = self.die1.unSelectedDieTexture
        case 2:
            self.currentDie.texture = self.die2.unSelectedDieTexture
        case 3:
            self.currentDie.texture = self.die3.unSelectedDieTexture
        case 4:
            self.currentDie.texture = self.die4.unSelectedDieTexture
        case 5:
            self.currentDie.texture = self.die5.unSelectedDieTexture
        case 6:
            self.currentDie.texture = self.die6.unSelectedDieTexture
        default:
            break
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
