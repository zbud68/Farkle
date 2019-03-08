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
        setDiceLocations()
        positionDice()
        addDice()
        setupDieFaces()
        setDiceLocations()
    }
    
    func setDiceLocations() {
        diePositions = [die1Position, die2Position, die3Position, die4Position, die5Position, die6Position]
        var dieID = 0
        for position in diePositions {
            placeHolderLocations[dieID] = position
            dieID += 1
        }
    }
    
    func setupDice() {
        die1.anchorPoint = CGPoint(x: 0.5, y: 0)
        die1.zRotation = 0
        die1Position = die1_PlaceHolder.position
            //CGPoint(x: 0, y: (placeHolderWindow.frame.midY + (placeHolderWindow.size.height / 2)) - (placeHolder.size.height / 2) - 36)
            //CGPoint(x: -(gameTable.size.width / 7), y: gameTable.frame.minY + 100)
        die2.zRotation = 0
        die2Position = die2_PlaceHolder.position
            //CGPoint(x: die1_PlaceHolder.position.x, y: die1_PlaceHolder.position.y - offsetY)
            //CGPoint(x: die1.position.x + die2.size.width, y: gameTable.frame.minY + 100)
        die3.zRotation = 0
        die3Position = die3_PlaceHolder.position
            //CGPoint(x: die2_PlaceHolder.position.x, y: die2_PlaceHolder.position.y - offsetY)
            //CGPoint(x: die2.position.x + die3.size.width, y: gameTable.frame.minY + 100)
        die4.zRotation = 0
        die4Position = die4_PlaceHolder.position
            //CGPoint(x: die3_PlaceHolder.position.x, y: die3_PlaceHolder.position.y - offsetY)
            //CGPoint(x: die3.position.x + die4.size.width, y: gameTable.frame.minY + 100)
        die5.zRotation = 0
        die5Position = die5_PlaceHolder.position
            //CGPoint(x: die4_PlaceHolder.position.x, y: die4_PlaceHolder.position.y - offsetY)
            //CGPoint(x: die4.position.x + die5.size.width, y: gameTable.frame.minY + 100)
        die6.zRotation = 0
        die6Position = die6_PlaceHolder.position
            //CGPoint(x: die5_PlaceHolder.position.x, y: die5_PlaceHolder.position.y - offsetY)
            //CGPoint(x: die5.position.x + die6.size.width, y: gameTable.frame.minY + 100)
        
    
        die1.name = "Die 1"
        die1.texture = GameConstants.Textures.Die1
        die1.faceValue = 1
        die1.pointValue = 10
        die1.selected = false
        die1.diePosition = diePositions[0]
        die1.zRotation = 0
        die1.alpha = 1
        die2.name = "Die 2"
        die2.texture = GameConstants.Textures.Die2
        die2.faceValue = 2
        die2.pointValue = 2
        die2.selected = false
        die2.diePosition = diePositions[1]
        die2.zRotation = 0
        die2.alpha = 1
        die3.name = "Die 3"
        die3.texture = GameConstants.Textures.Die3
        die3.faceValue = 3
        die3.pointValue = 3
        die3.selected = false
        die3.diePosition = diePositions[2]
        die3.zRotation = 0
        die3.alpha = 1

        die4.name = "Die 4"
        die4.texture = GameConstants.Textures.Die4
        die4.faceValue = 4
        die4.pointValue = 4
        die4.selected = false
        die4.diePosition = diePositions[3]
        die4.zRotation = 0
        die4.alpha = 1
        die5.name = "Die 5"
        die5.texture = GameConstants.Textures.Die5
        die5.faceValue = 5
        die5.pointValue = 5
        die5.selected = false
        die5.diePosition = diePositions[4]
        die5.zRotation = 0
        die5.alpha = 1
        die6.name = "Die 6"
        die6.texture = GameConstants.Textures.Die6
        die6.faceValue = 6
        die6.pointValue = 6
        die6.selected = false
        die6.diePosition = diePositions[5]
        die6.zRotation = 0

        switch currentGame.numDice {
        case 5:
            diceArray = [die1, die2, die3, die4, die5]
        case 6:
            diceArray = [die1, die2, die3, die4, die5, die6]
        default:
            break
        }
    }
    
    func setupDiePhysics() {
        let currentDice = diceArray
        
        for die in currentDice {
            die.anchorPoint = CGPoint(x: 0.5, y: 0)
            die.zRotation = 0
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
        let currentDice = diceArray
        
        for die in currentDice where die.selected != true {
            die.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            die.zRotation = 0
            die.zPosition = GameConstants.ZPositions.Dice
            die.size = GameConstants.Sizes.Dice
            
            switch die.name {
            case "Die 1":
                die1.position = die.diePosition
            case "Die 2":
                die2.position = die.diePosition
            case "Die 3":
                die3.position = die.diePosition
            case "Die 4":
                die4.position = die.diePosition
            case "Die 5":
                die5.position = die.diePosition
            case "Die 6":
                die6.position = die.diePosition
            default:
                break
            }
        }
    }
    
    func addDice() {
        let currentDice = diceArray
        
        for die in currentDice {
            placeHolderWindow.addChild(die)
        }
    }
    
    func setupDieFaces() {
        dieFace1.faceValue = 1
        dieFace1.pointValue = 10
        dieFace2.faceValue = 2
        dieFace2.pointValue = 2
        dieFace3.faceValue = 3
        dieFace3.pointValue = 3
        dieFace4.faceValue = 4
        dieFace4.pointValue = 4
        dieFace5.faceValue = 5
        dieFace5.pointValue = 5
        dieFace6.faceValue = 6
        dieFace6.pointValue = 6
        
        dieFacesArray = [dieFace1, dieFace2, dieFace3, dieFace4, dieFace5, dieFace6]
    }
    
    /*
    func removeSelectedDice(isComplete: (Bool) -> Void) {
        whatchaGot(isComplete: handlerBlock)
        if currentDiceArray.isEmpty {
            startNewRoll()
        } else {
            var dieID = 0
            for die in currentDiceArray {
                if die.selected == true {
                    selectedDiceArray.append(die)
                    currentDiceArray.remove(at: dieID)
                    dieID += 1
                }
            }
        }
        print("current dice array: \(currentDiceArray.count)")
        print("selected dice array: \(selectedDiceArray.count)")
        isComplete(true)
    }
    */
}
