//
//  Dice_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    
    func getDice() {
        setupDice()
        setupDiePhysics()
        addDice()
        positionDice()
        //getDiceRoll()
    }
    
    func setupDice() {
        die1.unSelectedDieTexture = GameConstants.Textures.Die1
        die1.selectedDieTexture = GameConstants.Textures.Die1Selected
        die1.texture = GameConstants.Textures.Die1
        die1.name = "Die 1"
        die2.unSelectedDieTexture = GameConstants.Textures.Die2
        die2.selectedDieTexture = GameConstants.Textures.Die2Selected
        die2.texture = GameConstants.Textures.Die2
        die2.name = "Die 2"
        die3.texture = GameConstants.Textures.Die3
        die3.unSelectedDieTexture = GameConstants.Textures.Die3
        die3.selectedDieTexture = GameConstants.Textures.Die3Selected
        die3.name = "Die 3"
        die4.texture = GameConstants.Textures.Die4
        die4.unSelectedDieTexture =  GameConstants.Textures.Die4
        die4.selectedDieTexture = GameConstants.Textures.Die4Selected
        die4.name = "Die 4"
        die5.texture = GameConstants.Textures.Die5
        die5.unSelectedDieTexture = GameConstants.Textures.Die5
        die5.selectedDieTexture = GameConstants.Textures.Die5Selected
        die5.name = "Die 5"
        die6.texture = GameConstants.Textures.Die6
        die6.unSelectedDieTexture = GameConstants.Textures.Die6
        die6.selectedDieTexture = GameConstants.Textures.Die6Selected
        die6.name = "Die 6"
        
        switch currentGame.numDice {
        case 5:
            defaultDiceArray = [die1, die2, die3, die4, die5]
        case 6:
            defaultDiceArray = [die1, die2, die3, die4, die5, die6]
        default:
            break
        }
        currentDiceArray = defaultDiceArray
        for die in defaultDiceArray {
            currentDice.append(die)
        }
    }
    
    func setupDiePhysics() {
        for die in currentDiceArray {
            die.physicsBody = SKPhysicsBody(rectangleOf: GameConstants.Sizes.Dice)
            die.physicsBody?.affectedByGravity = false
            die.physicsBody?.isDynamic = true
            die.physicsBody?.allowsRotation = true
            die.physicsBody?.categoryBitMask = 1
            die.physicsBody?.contactTestBitMask = 1
            die.physicsBody?.collisionBitMask = 1
            die.physicsBody?.restitution = 0.5
            die.physicsBody?.linearDamping = 4
            die.physicsBody?.angularDamping = 5
        }
    }
    
    func positionDice() {
        for die in currentDiceArray {
            die.zRotation = 0
            die.zPosition = GameConstants.ZPositions.Dice
            die.size = GameConstants.Sizes.Dice
            
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
    
    func addDice() {
        for die in currentDiceArray {
            gameTable.addChild(die)
        }
    }

    func resetDice() {
        die1.texture = die1.unSelectedDieTexture
        die1.name = "Die 1"
        dieFace1.faceValue = 10
        die2.texture = die2.unSelectedDieTexture
        die2.name = "Die 2"
        dieFace2.faceValue = 2
        die3.texture = die3.unSelectedDieTexture
        die3.name = "Die 3"
        dieFace3.faceValue = 3
        die4.texture = die4.unSelectedDieTexture
        die4.name = "Die 4"
        dieFace4.faceValue = 4
        die6.texture = die6.unSelectedDieTexture
        die6.name = "Die 6"
        dieFace6.faceValue = 6
        
        for die in currentDiceArray {
            die.selected = false
        }
    }
    
    func removeSelectedDice(isComplete: (Bool) -> Void) {
        whatchaGot(isComplete: handlerBlock)
        if currentDiceArray.isEmpty {
            startNewRoll()
        } else {
            var id = 0
            for die in currentDiceArray {
                if die.selected == true {
                    currentDiceArray.remove(at: id)
                    id += 1
                }
            }
        }
        print("current dice count: \(currentDiceArray.count)")
        isComplete(true)
    }
}
