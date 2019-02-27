//
//  Dice_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    
    func setupDice() {
        die1.faceValue = 1
        die1.UnSelectedDieTexture = unSelectedTextures[die1.faceValue - 1]
        die1.SelectedDieTexture = selectedTextures[die1.faceValue - 1]
        die1.texture = GameConstants.Textures.Die1
        die1.name = "Die 1"
        die2.faceValue = 2
        die2.UnSelectedDieTexture = unSelectedTextures[die2.faceValue - 1]
        die2.SelectedDieTexture = selectedTextures[die2.faceValue - 1]
        die2.texture = GameConstants.Textures.Die2
        die2.name = "Die 2"
        die3.faceValue = 3
        die3.texture = GameConstants.Textures.Die3
        die3.UnSelectedDieTexture = unSelectedTextures[die3.faceValue - 1]
        die3.SelectedDieTexture = selectedTextures[die3.faceValue - 1]
        die3.name = "Die 3"
        die4.faceValue = 4
        die4.texture = GameConstants.Textures.Die4
        die4.UnSelectedDieTexture = unSelectedTextures[die4.faceValue - 1]
        die4.SelectedDieTexture = selectedTextures[die4.faceValue - 1]
        die4.name = "Die 4"
        die5.faceValue = 5
        die5.texture = GameConstants.Textures.Die5
        die5.UnSelectedDieTexture = unSelectedTextures[die5.faceValue - 1]
        die5.SelectedDieTexture = selectedTextures[die5.faceValue - 1]
        die5.name = "Die 5"
        die6.faceValue = 6
        die6.texture = GameConstants.Textures.Die6
        die6.UnSelectedDieTexture = unSelectedTextures[die6.faceValue - 1]
        die6.SelectedDieTexture = selectedTextures[die6.faceValue - 1]
        die6.name = "Die 6"
        

        switch currentGame.numDice {
        case 5:
            diceArray = [die1, die2, die3, die4, die5]
        case 6:
            diceArray = [die1, die2, die3, die4, die5, die6]
        default:
            break
        }
        currentDiceArray = diceArray
        currentDie = currentDiceArray[0]
    
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
        positionDice()
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
            
            if die6.parent == nil {
                gameTable.addChild(die)
            }
        }
    }
    
    func resetDice() {
        die1.texture = unSelectedTextures[die1.faceValue - 1]
        die1.name = "Die 1"
        die1.faceValue = 1
        die2.texture = unSelectedTextures[die2.faceValue - 1]
        die2.name = "Die 2"
        die2.faceValue = 2
        die3.texture = unSelectedTextures[die3.faceValue - 1]
        die3.name = "Die 3"
        die3.faceValue = 3
        die4.texture = unSelectedTextures[die4.faceValue - 1]
        die4.name = "Die 4"
        die4.faceValue = 4
        die5.texture = unSelectedTextures[die5.faceValue - 1]
        die5.name = "Die 5"
        die5.faceValue = 5
        die6.texture = unSelectedTextures[die6.faceValue - 1]
        die6.name = "Die 6"
        die6.faceValue = 6
        
        zeroOutDieCount()
        for die in currentDiceArray {
            die.selected = false
            die.selectable = true
            die.rollable = true
        }
    }
 
    //MARK: ********** Roll Dice **********
    
    func rollDice() {
        if currentPlayer.firstRoll == true {
            currentPlayer.currentRollScore = 0
            currentScore = 0
            resetDice()
        }
        getFaceValues()
        rollDiceAction(isComplete: handlerBlock)
        //checkForFarkle(isComplete: handlerBlock)
        currentPlayer.firstRoll = false
    }
    
    func getFaceValues() {
        currentRoll.removeAll()
        for die in currentDiceArray where die.rollable == true{
            currentDie = die
            currentDie.faceValue = Int(arc4random_uniform(6)+1)
            currentDie.selected = false
            switch currentDie.faceValue {
            case 1:
                dieCount[1]! += 1
            case 2:
                dieCount[2]! += 1
            case 3:
                dieCount[3]! += 1
            case 4:
                dieCount[4]! += 1
            case 5:
                dieCount[5]! += 1
            case 6:
                dieCount[5]! += 1
            default:
                break
            }
            currentRoll.append(die.faceValue)
        }
        print("Current Roll: \(currentRoll)")
    }
    
    func rollDiceAction(isComplete: (Bool) -> Void) {
        
        for die in currentDiceArray where die.rollable == true{
            
            let Wait = SKAction.wait(forDuration: 0.75)
            
            if let RollAction = SKAction(named: "RollDice") {
                rollAction = RollAction
            }
            
            let FadeOut = SKAction.fadeAlpha(to: 0, duration: 0.75)
            let FadeIn = SKAction.fadeAlpha(to: 1, duration: 0.75)
            
            let SetFace = SKAction.run {
                switch die.faceValue {
                case 1:
                    die.texture = self.die1.UnSelectedDieTexture
                case 2:
                    die.texture = self.die2.UnSelectedDieTexture
                case 3:
                    die.texture = self.die3.UnSelectedDieTexture
                case 4:
                    die.texture = self.die4.UnSelectedDieTexture
                case 5:
                    die.texture = self.die5.UnSelectedDieTexture
                case 6:
                    die.texture = self.die6.UnSelectedDieTexture
                default:
                    break
                }
            }
            
            let RepositionDice = SKAction.run {
                self.repositionDice()
            }
            
            let MoveAction = SKAction.run {
                let randomX = CGFloat(arc4random_uniform(5) + 5)
                let randomY = CGFloat(arc4random_uniform(2) + 3)
                
                die.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
                die.physicsBody?.applyTorque(3)
            }
            
            let Group = SKAction.group([rollAction, MoveAction])
            let Seq = SKAction.sequence([Group, Wait, FadeOut, RepositionDice, SetFace, FadeIn])
            
            die.position = CGPoint(x: 0, y: 0)
            
            die.run(Seq)
        }
        isComplete(true)
    }
    
    func evaluateCurrentRoll(isComplete: (Bool) -> Void) {
        checkForScoringCombos(isComplete: handlerBlock)
        checkForFarkle(isComplete: handlerBlock)
    }
    
    func checkForScoringCombos(isComplete: (Bool) -> Void) {
        checkForAStraight(isComplete: handlerBlock)
        if straight == true {
            currentScore += 1500
            straight.toggle()
            startNewRoll()
        } else {
            checkFor3orMoreOfAKind(isComplete: handlerBlock)
        }
        checkForFullHouse(isComplete: handlerBlock)
        tallyTheScores(isComplete: handlerBlock)
        isComplete(true)
    }
    
    func checkForAStraight(isComplete: (Bool) -> Void) {
        let currentRollSorted = currentRoll.sorted()
        if currentGame.numDice == 6 {
            if currentRollSorted == sixDieStraight {
                straight = true
            }
        } else if currentRollSorted == lowStraight || currentRollSorted == highStraight {
            straight = true
        }
        if straight == true {
            print("Got a Straight")
        }
        isComplete(true)
    }

    func checkFor3orMoreOfAKind(isComplete: (Bool) -> Void) {
        for (key,value) in dieCount {
            switch value {
            case 1,2:
                processDie(key: key, value: value, isComplete: handlerBlock)
            case 3:
                threeOfAKind.toggle()
            case 4:
                fourOfAKind.toggle()
                threeOfAKind.toggle()
            case 5:
                fiveOfAKind.toggle()
                fourOfAKind.toggle()
                threeOfAKind.toggle()
            case 6:
                sixOfAKind.toggle()
                fiveOfAKind.toggle()
                fourOfAKind.toggle()
                threeOfAKind.toggle()
            default:
                break
            }
        }
        isComplete(true)
    }
    
    func processDie(key: Int, value: Int, isComplete: (Bool) -> Void) {
        switch key {
        case 1:
            if value == 1 {
                currentScore += 100
            } else if value == 2 {
                currentScore += 200
            }
        case 2:
            if value == 2 {
                pairs += 1
            }
        case 3:
            if value == 2 {
                pairs += 1
            }
        case 4:
            if value == 2 {
                pairs += 1
            }
        case 5:
            if value == 1 {
                currentScore += 50
            } else if value == 2 {
                currentScore += 100
            }
        case 6:
            if value == 2 {
                pairs += 1
            }
        default:
            break
        }
        isComplete(true)
    }
    
    func checkForFullHouse(isComplete: (Bool) -> Void) {
        if threeOfAKind == true && pairs == 1 {
            fullHouse = true
            threeOfAKind.toggle()
        }
        isComplete(true)
    }
    
    func tallyTheScores(isComplete: (Bool) -> Void) {
        let combosArray = [threeOfAKind, fourOfAKind, fiveOfAKind, sixOfAKind, threePairs, fullHouse]
        for combo in combosArray where combo == true {
            switch combo {
            case threeOfAKind:
                for (key, value) in dieCount where value == 3 {
                    switch key {
                    case 1:
                        currentScore += key * 1000
                    default:
                        currentScore += key * 100
                    }
                }
            case fourOfAKind:
                for (key, value) in dieCount where value == 4 {
                    switch key {
                    case 1:
                        currentScore += (key * 1000) * 2
                    default:
                        currentScore += (key * 100) * 2
                    }
                }
            case fiveOfAKind:
                for (key, value) in dieCount where value == 5 {
                    switch key {
                    case 1:
                        currentScore += (key * 1000) * 3
                    default:
                        currentScore += (key * 100) * 3
                    }
                }
            case sixOfAKind:
                for (key, value) in dieCount where value == 6 {
                    switch key {
                    case 1:
                        currentScore += (key * 1000) * 4
                    default:
                        currentScore += (key * 100) * 4
                    }
                }
            default:
                break
            }
        }
        isComplete(true)
    }
    
    func checkForFarkle(isComplete: (Bool) -> Void) {
        
        farkleCheck: for (key,value) in dieCount where value > 0 {
            switch key {
            case 1:
                currentPlayer.hasScoringDice = true
                break farkleCheck
            case 2:
                currentPlayer.hasScoringDice = false
            case 3:
                currentPlayer.hasScoringDice = false
            case 4:
                currentPlayer.hasScoringDice = false
            case 5:
                currentPlayer.hasScoringDice = true
                break farkleCheck
            case 6:
                currentPlayer.hasScoringDice = false
            default:
                break
            }
        }
        if currentPlayer.hasScoringDice == false {
            scoringCombo = false
            playerState = .Farkle
        }
        zeroOutDieCount()
        isComplete(true)
    }

    func repositionDice() {

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
    
    func zeroOutDieCount() {
        dieCount = [1:0, 2:0, 3:0, 4:0, 5:0, 6:0]
    }
}
