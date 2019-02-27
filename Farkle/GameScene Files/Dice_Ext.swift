//
//  Dice_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    
    func setupDieFaces() {
        dieFaceArray = [dieFace1, dieFace2, dieFace3, dieFace4, dieFace5, dieFace6]
    }

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
        
        for die in currentDiceArray {
            die.selected = false
            die.selectable = true
        }
    }
 
    //MARK: ********** Roll Dice **********
    
    func rollDice() {
        if currentPlayer.firstRoll == true {
            currentPlayer.currentRollScore = 0
            pointsAvailable = 0
            currentScore = 0
            resetDice()
            repositionDice()
        }
        
        getFaceValues()
        rollDiceAction(isComplete: handlerBlock)
        checkForFarkle()
        currentPlayer.firstRoll = false
    }
    
    func getFaceValues() {
        currentRoll.removeAll()
        for die in currentDiceArray where die.rollable == true{
            currentDie = die
            currentDie.faceValue = Int(arc4random_uniform(6)+1)
            currentDie.countThisRoll += 1
            currentDie.selected = false
            
            currentRoll.append(currentDie.faceValue)
        }
    }
    
    func evaluateCurrentRoll() {
        checkForScoringCombos()
        checkForFarkle()
    }
    
    func checkForScoringCombos() {
        let currentRollSorted = currentRoll.sorted()
        if currentGame.numDice == 6 {
            if currentRollSorted == sixDieStraight {
                straight = true
            }
        } else if currentRollSorted == lowStraight || currentRollSorted == highStraight {
            straight = true
        }
        if straight != true {
            for die in currentDiceArray where die.countThisRoll > 0 && die.selected == true {
                switch die.countThisRoll {
                case 1:
                    if die.faceValue == 1 {
                         currentScore += 100
                    } else if die.faceValue == 5 {
                        currentScore += 50
                    }
                case 2:
                    if die.faceValue == 1 {
                        currentScore += 200
                    } else if die.faceValue == 5 {
                        currentScore += 100
                    } else {
                        pairs += 1
                    }
                case 3:
                    threeOfAKind = true
                case 4:
                    fourOfAKind = true
                case 5:
                    fiveOfAKind = true
                case 6:
                    sixOfAKind = true
                default:
                    break
                }
            }
            
            if threeOfAKind == true && pairs == 1 {
                fullHouse = true
                threeOfAKind = false
                pairs = 0
                currentScore += 750
                scoringCombo = true
            }
            if pairs == 3 {
                threePairs = true
                pairs = 0
                currentScore += 500
                scoringCombo = true
            }
            if threeOfAKind == true {
                for die in currentDiceArray where die.countThisRoll == 3 {
                    if die.faceValue == 1 || die.faceValue == 5 {
                        currentScore += (die.countThisRoll * 10)
                    }
                    currentScore += (die.faceValue * 100)
                }
                scoringCombo = true
            }
            if fourOfAKind == true {
                for die in currentDiceArray where die.countThisRoll == 4 {
                    if die.faceValue == 1 || die.faceValue == 5 {
                        currentScore += ((die.countThisRoll * 10) * 2)
                    }
                    currentScore += ((die.faceValue * 100) * 2)
                }
                scoringCombo = true
            }
            if fiveOfAKind == true {
                for die in currentDiceArray where die.countThisRoll == 5 {
                    if die.faceValue == 1 || die.faceValue == 5 {
                        currentScore += ((die.countThisRoll * 10) * 3)
                    }
                    currentScore += ((die.faceValue * 100) * 3)
                }
                scoringCombo = true
            }
            if sixOfAKind == true {
                for die in currentDiceArray where die.countThisRoll == 6 {
                    if die.faceValue == 1 || die.faceValue == 5 {
                        currentScore += ((die.countThisRoll * 10) * 4)
                    }
                    currentScore += ((die.faceValue * 100) * 4)
                }
                scoringCombo = true
           }
        } else {
            scoringCombo = true
        }
        if straight == true {
            playerState = .NewRoll
        }
    }
    
    func checkForFarkle() {
        if currentPlayer.firstRoll == false {
            for die in currentDiceArray where die.selected == false {
                print("Roll: \(die.faceValue)\nScoring Combo: \(scoringCombo)")
                switch die.faceValue {
                case 2, 3, 4, 6:
                    die.scoring = false
                default:
                    die.scoring = true
                }
                if die.scoring == false && scoringCombo == false {
                    currentPlayer.hasScoringDice = false
                } else {
                    for die in currentDiceArray {
                        die.scoring = false
                        scoringCombo = false
                    }
                }
            }
        }
        if currentPlayer.hasScoringDice == false {
            playerState = .Farkle
        }
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
}
