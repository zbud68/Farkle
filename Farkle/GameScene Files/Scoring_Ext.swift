//
//  Scoring_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 3/1/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    func resetVariable() {
        currentRoll.removeAll()
        scoringCombo.scoringDice = false
        scoringCombo.pairs = 0
        scoringCombo.threeOAK = false
        scoringCombo.threePair = false
        scoringCombo.straight = false
        scoringCombo.fullHouse = false
        scoringCombo.fourOAK = false
        scoringCombo.fiveOAK = false
        scoringCombo.sixOAK = false
    }
    
    func rollDice() {
        let currentDiceRoll = currentDiceArray
        
        var id = 0
        for die in currentDiceRoll {
            die.faceValue = Int(arc4random_uniform(6)+1)
            print("faceValue: \(die.faceValue)\n")
            switch die.faceValue {
            case 1:
                die.texture = GameConstants.Textures.Die1
                dieFace1.countThisRoll += 1
                print("dieFace1 count: \(dieFace1.countThisRoll)\n")
            case 2:
                die.texture = GameConstants.Textures.Die2
                dieFace2.countThisRoll += 1
                print("dieFace2 count: \(dieFace2.countThisRoll)\n")
            case 3:
                die.texture = GameConstants.Textures.Die3
                dieFace3.countThisRoll += 1
                print("dieFace3 count: \(dieFace3.countThisRoll)\n")
            case 4:
                die.texture = GameConstants.Textures.Die4
                dieFace4.countThisRoll += 1
                print("dieFace4 count: \(dieFace4.countThisRoll)\n")
            case 5:
                die.texture = GameConstants.Textures.Die5
                dieFace5.countThisRoll += 1
                print("dieFace5 count: \(dieFace5.countThisRoll)\n")
            case 6:
                die.texture = GameConstants.Textures.Die6
                dieFace6.countThisRoll += 1
                print("dieFace6 count: \(dieFace6.countThisRoll)\n")
            default:
                break
            }
            id += 1
        }
        tallyTheScore()
    }
    
    func tallyTheScore() {
        checkForAStraight(isComplete: handlerBlock)
        checkForThreeOfAKind(isComplete: handlerBlock)
        printFindings()
    }

    func checkForAStraight(isComplete: (Bool) -> Void) {
        var dieFaces: [Int] = []
        for die in currentDiceArray {
            dieFaces.append(die.faceValue)
        }
        dieFaces = dieFaces.sorted()
        
        if dieFaces == scoringCombo.sixDieStraight {
            scoringCombo.straight = true
        } else if dieFaces == scoringCombo.lowStraight || dieFaces == scoringCombo.highStraight {
            scoringCombo.straight = true
        }
        isComplete(true)
    }

    func checkForThreeOfAKind(isComplete: (Bool) -> Void) {
        var faceValue = 0
        var dieCount = 0
        var id = 0
        for dieFace in dieFacesArray {
            dieCount = dieFace.countThisRoll
            faceValue = dieFace.faceValue
            
            switch dieCount {
            case 1:
                if faceValue == 1 || faceValue == 5 {
                    scoringCombo.scoringDice = true
                }
                break
            case 2:
                if faceValue == 1 || faceValue == 5 {
                    scoringCombo.scoringDice = true
                }
                scoringCombo.pairs += 1
                break
            case 3:
                scoringCombo.threeOAK = true
                scoringCombo.scoringDice = true
                scoringDiceFaceValue = faceValue
                break
            case 4:
                scoringCombo.fourOAK = true
                scoringCombo.scoringDice = true
                break
            case 5:
                scoringCombo.fiveOAK = true
                scoringCombo.scoringDice = true
                break
            case 6:
                scoringCombo.sixOAK = true
                scoringCombo.scoringDice = true
                break
            default:
                break
            }
            if currentGame.numDice == 5 {
                if scoringCombo.threeOAK == true && scoringCombo.pairs == 1 {
                    scoringCombo.fullHouse = true
                    scoringCombo.threeOAK = false
                    scoringCombo.scoringDice = true
                }
            }
            
            if scoringCombo.pairs == 3 {
                scoringCombo.threePair = true
                scoringCombo.scoringDice = true
            }
            id += 1
        }
        
        if scoringCombo.scoringDice == false {
            print("farkle")
            farkle()
        }
        
        getSelectedDiceScore()
        printFindings()
        isComplete(true)
    }
    
    func getSelectedDiceScore() {
        
        
        
        /*
        var faceValue = 0
        var count = 0

        for dieFace in dieFacesArray {
            faceValue = dieFace.faceValue
            count = dieFace.countThisRoll
        }

        var faceID = 0
        var dieID = 0
        for dieFace in dieFacesArray {
            faceValue = dieFace.faceValue
            
            var countThisRoll = count
            for die in currentDiceArray {
                var dieValue = die.faceValue
                if faceValue == dieValue && die.selected == true {
                    selectedDiceArray.append(currentDiceArray[dieID])
                    selectedDiceArray[dieID].faceValue = faceValue
                    selectedDiceArray[dieID].countThisRoll = countThisRoll
                }
                dieID += 1
            }
            faceID += 1
        }
        */
        whatchaGot(isComplete: handlerBlock)
    }
    
    func printFindings() {
        if scoringCombo.scoringDice == true {
            print("scoring dice")
        }
        if scoringCombo.pairs > 0 {
            print("pairs: \(scoringCombo.pairs)")
        }
        if scoringCombo.threePair == true {
            print("three pair")
        }
        if scoringCombo.threeOAK == true {
            print("three of a kind")
        }
        if scoringCombo.fourOAK == true {
            print("four of a kind")
        }
        if scoringCombo.fiveOAK == true {
            print("five of a kind")
        }
        if scoringCombo.sixOAK == true {
            print("six of a kind")
        }
        if scoringCombo.fullHouse == true {
            print("full House")
        }
        if scoringCombo.straight == true {
            print("straight")
        }
        
    }
    
    
    func whatchaGot(isComplete: (Bool) -> Void) {
        for die in selectedDiceArray {
            print("entered first for statement")
            let face = die.faceValue
            print("selected dice: \(face)")
        }
        for die in selectedDiceArray {
            print("entered second for statement")
            let faceValue = die.faceValue
            let pointValue = die.faceValue
            //let texture = die.texture
    
            var rollScore = currentPlayer.currentRollScore
            print("entering switch")
            var count = 0

            for dieFace in dieFacesArray {
                count = dieFace.countThisRoll
            }
            
            switch count {
            case 1:
                if faceValue == 1 || faceValue == 5 {
                    rollScore += pointValue * 10
                    print("rollScore: \(rollScore)")
                }
            case 2:
                if faceValue == 1 || faceValue == 5 {
                    rollScore += pointValue * 10
                    print("rollScore: \(rollScore)")
                }
            case 3:
                if scoringCombo.threeOAK == true {
                    rollScore += (pointValue * 100)
                    print("rollScore: \(rollScore)")
                }
            case 4:
                if scoringCombo.fourOAK == true {
                    rollScore += (pointValue * 100) * 2
                    print("rollScore: \(rollScore)")
                }
            case 5:
                if scoringCombo.fiveOAK == true {
                    rollScore += (pointValue * 100) * 3
                    print("rollScore: \(rollScore)")
                }
            case 6:
                if scoringCombo.sixOAK == true {
                    rollScore += (pointValue * 100) * 4
                    print("rollScore: \(rollScore)")
                }
            default:
                break
            }
            if scoringCombo.straight == true {
                rollScore += 1500
                print("rollScore: \(rollScore)")
                //startNewRoll()
            } else if scoringCombo.fullHouse == true {
                if currentGame.numDice == 5 {
                    rollScore += 750
                    print("rollScore: \(rollScore)")
                    //startNewRoll()
                }
            }
            if currentGame.numDice == 6 && scoringCombo.threePair == true {
                rollScore += 500
                print("rollScore: \(rollScore)")
                startNewRoll()
            }
            print("rollScore: \(rollScore)")
            currentScore += rollScore
            currentScoreLabel.text = String(currentScore)
        }
        print("current Score: \(currentScore)")
        isComplete(true)
    }
}
        
        /*
        for (combo, value) in ScoringCombo {
            switch combo {
            case "sixOfAKind":
                print("six of a kind")
                if value == true {
                    scoreMultiplier = 4
                }
                break
            case "fiveOfAKind":
                print("five of a kind")
                if value == true {
                    scoreMultiplier = 3
                }
                break
            case "fourOfAKind":
                print("four of a kind")
                if value == true {
                    scoreMultiplier = 2
                }
                break
            case "threeOfAKind":
                if currentGame.numDice == 5 {
                    if value == true && pairs == 1 {
                        print("full House")
                        currentPlayer.currentRollScore += 750
                        startNewRoll()
                        break
                    }
                }
                default:
                    break
            }
        }
        isComplete(true)
    */

class ScoringCombo {
    let lowStraight = [1,2,3,4,5]
    let highStraight = [2,3,4,5,6]
    let sixDieStraight = [1,2,3,4,5,6]
    
    var pairs: Int = 0
    var scoreMultiplier: Int = 1
    var scoringDice: Bool = false
    var threeOAK: Bool = false
    var threePair: Bool = false
    var straight: Bool = false
    var fullHouse: Bool = false
    var fourOAK: Bool = false
    var fiveOAK: Bool = false
    var sixOAK: Bool = false
}
