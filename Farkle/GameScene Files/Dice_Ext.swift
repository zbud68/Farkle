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
        positionDice()
        addDice()
        setupDieFaces()
    }
    
    func setupDice() {
        die1.name = "Die 1"
        die1.texture = GameConstants.Textures.Die1
        die1.faceValue = 1
        die1.pointValue = 1
        die1.selected = false
        
        die2.name = "Die 2"
        die2.texture = GameConstants.Textures.Die2
        die2.faceValue = 2
        die2.pointValue = 1
        die2.selected = false

        die3.name = "Die 3"
        die3.texture = GameConstants.Textures.Die3
        die3.faceValue = 3
        die3.pointValue = 1
        die3.selected = false

        die4.name = "Die 4"
        die4.texture = GameConstants.Textures.Die4
        die4.faceValue = 4
        die4.pointValue = 1
        die4.selected = false

        die5.name = "Die 5"
        die5.texture = GameConstants.Textures.Die5
        die5.faceValue = 5
        die5.pointValue = 1
        die5.selected = false

        die6.name = "Die 6"
        die6.texture = GameConstants.Textures.Die6
        die6.faceValue = 6
        die6.pointValue = 1
        die6.selected = false

        switch currentGame.numDice {
        case 5:
            currentDiceArray = [die1, die2, die3, die4, die5]
        case 6:
            currentDiceArray = [die1, die2, die3, die4, die5, die6]
        default:
            break
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
    
    func setupDieFaces() {
        dieFace1.faceValue = 1
        dieFace2.faceValue = 2
        dieFace3.faceValue = 3
        dieFace4.faceValue = 4
        dieFace5.faceValue = 5
        dieFace6.faceValue = 6
        
        dieFacesArray = [dieFace1, dieFace2, dieFace3, dieFace4, dieFace5, dieFace6]
    }
    
    func removeSelectedDice(isComplete: (Bool) -> Void) {
        //whatchaGot(isComplete: handlerBlock)
        if currentDiceArray.isEmpty {
            startNewRoll()
        } else {
            var id = 0
            for die in currentDiceArray {
                if die.selected == true {
                    selectedDiceArray.append(die)
                    currentDiceArray.remove(at: id)
                    id += 1
                }
            }
        }
        print("selected dice array: \(selectedDiceArray)")
        isComplete(true)
    }
}
