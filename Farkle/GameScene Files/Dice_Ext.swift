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
        setupDieFaces()
        addDice()
        
        die1.texture = die1.currentFace.unSelectedTexture
        //setDiceLocations()
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
        
        die1.name = "Die 1"
        die1.currentFace = dieFace1
        die1.texture = die1.currentFace.unSelectedTexture
        die1.selected = false
        die1.position = die1_PlaceHolder.position

        die2.name = "Die 2"
        die2.currentFace = dieFace2
        die2.texture = die2.currentFace.unSelectedTexture
        die2.selected = false
        die2.position = die2_PlaceHolder.position

        die3.name = "Die 3"
        die3.currentFace = dieFace3
        die3.texture = die3.currentFace.unSelectedTexture
        die3.selected = false
        die3.position = die3_PlaceHolder.position

        die4.name = "Die 4"
        die4.currentFace = dieFace4
        die4.texture = die4.currentFace.unSelectedTexture
        die4.selected = false
        die4.position = die4_PlaceHolder.position

        die5.name = "Die 5"
        die5.currentFace = dieFace5
        die5.texture = die5.currentFace.unSelectedTexture
        die5.selected = false
        die5.position = die5_PlaceHolder.position

        die6.name = "Die 6"
        die6.currentFace = dieFace6
        die6.texture = die6.currentFace.unSelectedTexture
        die6.selected = false
        die6.position = die6_PlaceHolder.position

        diceArray = [die1, die2, die3, die4, die5]
        if currentGame.numDice == 6 {
            diceArray.append(die6)
        }
    }
    
    func setupDiePhysics() {
        let currentDice = diceArray
        
        for die in currentDice {
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
        
        for die in currentDice where !die.selected {
            die.zPosition = GameConstants.ZPositions.Dice
            die.zRotation = 0
            die.size = GameConstants.Sizes.Dice
            
            switch die.name {
            case "Die 1":
                die1.position = die1_PlaceHolder.position
            case "Die 2":
                die2.position = die2_PlaceHolder.position
            case "Die 3":
                die3.position = die3_PlaceHolder.position
            case "Die 4":
                die4.position = die4_PlaceHolder.position
            case "Die 5":
                die5.position = die5_PlaceHolder.position
            case "Die 6":
                die6.position = die6_PlaceHolder.position
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
        dieFace1.unSelectedTexture = GameConstants.Textures.Die1
        dieFace1.selectedTexture = GameConstants.Textures.Die1Selected
        
        dieFace2.unSelectedTexture = GameConstants.Textures.Die2
        dieFace2.selectedTexture = GameConstants.Textures.Die2Selected
        
        dieFace3.unSelectedTexture = GameConstants.Textures.Die3
        dieFace3.selectedTexture = GameConstants.Textures.Die3Selected
        
        dieFace4.unSelectedTexture = GameConstants.Textures.Die4
        dieFace4.selectedTexture = GameConstants.Textures.Die4Selected
        
        dieFace5.unSelectedTexture = GameConstants.Textures.Die5
        dieFace5.selectedTexture = GameConstants.Textures.Die5Selected
        
        dieFace6.unSelectedTexture = GameConstants.Textures.Die6
        dieFace6.selectedTexture = GameConstants.Textures.Die6Selected
        
        dieFaces = [dieFace1, dieFace2, dieFace3, dieFace4, dieFace5, dieFace6]
    }
    
    func setupPlaceHolderWindow() {
        placeHolderWindow = SKSpriteNode(texture: SKTexture(imageNamed: "DiePlaceHolderWindow"))
        placeHolderWindow.name = "Place Holder Window"
        placeHolderWindow.size = CGSize(width: 64, height: 310)
        placeHolderWindow.alpha = 1
        placeHolderWindow.zPosition = GameConstants.ZPositions.PlaceHolderWindow
        placeHolderWindow.position = CGPoint(x: gameTable.frame.midX + gameTable.size.width /  4, y: gameTable.frame.midY)
        gameTable.addChild(placeHolderWindow)
        setupPlaceHolderWindowPhysics()
        addDiePlaceHolders()
    }
    
    func setupPlaceHolderWindowPhysics() {
        
        placeHolderWindow.physicsBody = SKPhysicsBody(rectangleOf: placeHolderWindow.size, center: CGPoint(x: placeHolderWindow.frame.midX, y: placeHolderWindow.frame.midY))
        placeHolderWindow.physicsBody?.isDynamic = false
        placeHolderWindow.physicsBody?.affectedByGravity = false
        placeHolderWindow.physicsBody?.allowsRotation = false
        placeHolderWindow.physicsBody?.categoryBitMask = 3
        placeHolderWindow.physicsBody?.collisionBitMask = 3
        placeHolderWindow.physicsBody?.contactTestBitMask = 3
        
    }
    
    func setupDiePlaceHolders() {
        die1_PlaceHolder = SKSpriteNode(imageNamed: "Die1")
        die2_PlaceHolder = SKSpriteNode(imageNamed: "Die2")
        die3_PlaceHolder = SKSpriteNode(imageNamed: "Die3")
        die4_PlaceHolder = SKSpriteNode(imageNamed: "Die4")
        die5_PlaceHolder = SKSpriteNode(imageNamed: "Die5")
        die6_PlaceHolder = SKSpriteNode(imageNamed: "Die6")
        
        placeHolderArray = [die1_PlaceHolder, die2_PlaceHolder, die3_PlaceHolder, die4_PlaceHolder, die5_PlaceHolder, die6_PlaceHolder]
        
        for diePlaceHolder in placeHolderArray {
            diePlaceHolder.size  = CGSize(width: 48, height: 48)
            diePlaceHolder.zPosition = GameConstants.ZPositions.PlaceHolder
            diePlaceHolder.alpha = 0
        }
        
        die1_PlaceHolder.position = CGPoint(x: 0, y: (placeHolderWindow.frame.midY + (placeHolderWindow.size.height / 2)) - (placeHolder.size.height / 2) - 36)
        die2_PlaceHolder.position = CGPoint(x: 0, y: die1_PlaceHolder.position.y - offsetY)
        die3_PlaceHolder.position = CGPoint(x: 0, y: die2_PlaceHolder.position.y - offsetY)
        die4_PlaceHolder.position = CGPoint(x: 0, y: die3_PlaceHolder.position.y - offsetY)
        die5_PlaceHolder.position = CGPoint(x: 0, y: die4_PlaceHolder.position.y - offsetY)
        die6_PlaceHolder.position = CGPoint(x: 0, y: die5_PlaceHolder.position.y - offsetY)
        
        addDiePlaceHolders()
    }
    
    func addDiePlaceHolders() {
        for placeHolder in placeHolderArray {
            placeHolderWindow.addChild(placeHolder)
            placeHolderLocations.append(placeHolder.position)
        }
    }
    
    
}
