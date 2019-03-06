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
    
    func getDiceRoll() {
        resetVariable()
        
        var currentDie = 0
        var id = 0
        for _ in 1...currentGame.numDice {
            currentDie = Int(arc4random_uniform(6)+1)
            currentRoll.append((currentDie, currentDie, 0))
            id += 1
        }
        id = 0
        for _ in 1...currentGame.numDice {
            let currentDie = currentRoll[id].0
            if currentDie == 1 {
                currentRoll[id].1 = currentDie * 10
            } else {
                currentRoll[id].1 = currentDie
            }
            currentRoll[id].2 = 0
            id += 1
        }
        id = 0
        var dieFaces: [Int] = []
        for (face, _, _) in currentRoll {
            dieFaces.append(face)
            id += 1
        }
        print(dieFaces)
        matchDieFaceToDieImage()
        getCount()
    }
    
    func matchDieFaceToDieImage() {
        var currentRollFace: [(Int, Int)] = []
        var id = 0
        for (face, _, count) in currentRoll {
            let faceValue = face
            let dieCount = count
            currentRollFace.append((faceValue, dieCount))
            id += 1
        }
        
        var currentDieFace: [Int] = []
        id = 0
        for die in currentDiceArray {
            let faceValue = die.faceValue
            currentDieFace.append(faceValue)
            id += 1
        }
        
        var faceID = 0
        var faceValue = 0
        var dieCount = 0
        for (face, count) in currentRollFace {
            var dieFaceID = 0
            for dieFace in currentDieFace {
                if face == dieFace {
                    faceValue = currentRollFace[faceID].0
                    dieCount = currentRollFace[faceID].1
                }
                dieFaceID += 1
            }
            faceID += 1
        }
    }
    
    func getCount() {
        var id = 0
        for (face, _, _) in currentRoll {
            let faceValue = face

            switch faceValue {
            case 1:
                var die = 0
                for (face, _, _) in currentRoll {
                    if face == faceValue {
                        currentRoll[die].2 += 1
                        break
                    }
                    die += 1
                }
                break
            case 2:
                var die = 0
                for (face, _, _) in currentRoll {
                    if face == faceValue {
                        currentRoll[die].2 += 1
                        break
                    }
                    die += 1
                }
                break
            case 3:
                var die = 0
                for (face, _, _) in currentRoll {
                    if face == faceValue {
                        currentRoll[die].2 += 1
                        break
                    }
                    die += 1
                }
                break
            case 4:
                var die = 0
                for (face, _, _) in currentRoll {
                    if face == faceValue {
                        currentRoll[die].2 += 1
                        break
                    }
                    die += 1
                }
                break
            case 5:
                var die = 0
                for (face, _, _) in currentRoll {
                    if face == faceValue {
                        currentRoll[die].2 += 1
                        break
                    }
                    die += 1
                }
                break
            case 6:
                var die = 0
                for (face, _, _) in currentRoll {
                    if face == faceValue {
                        currentRoll[die].2 += 1
                        break
                    }
                    die += 1
                }
                break
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
    }

    func checkForAStraight(isComplete: (Bool) -> Void) {
 
        var faceValues: [Int] = [Int]()
         for (face, _, _) in currentRoll {
            faceValues.append(face)
            faceValues = faceValues.sorted()
        }
        if faceValues == scoringCombo.sixDieStraight {
            scoringCombo.straight = true
        } else if faceValues == scoringCombo.lowStraight || faceValues == scoringCombo.highStraight {
            scoringCombo.straight = true
        }
        isComplete(true)
    }

    func checkForThreeOfAKind(isComplete: (Bool) -> Void) {
        var id = 0
        for (face, _, count) in currentRoll {
            let currentDie = currentRoll[id].1
            let faceValue = face
            //let pointValue = point
            let dieCount = count
            
            print("dieCount: \(dieCount)")
            
            switch dieCount {
            case 1:
                if faceValue == 1 || faceValue == 5 {
                    scoringCombo.scoringDice = true
                    
                    print("face value: \(faceValue)")
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
            if scoringCombo.threeOAK == true && scoringCombo.pairs == 1 {
                scoringCombo.fullHouse = true
                scoringCombo.threeOAK = false
                scoringCombo.scoringDice = true
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
    }
    
    func getSelectedDiceScore() {
        var faceID = 0
        var dieID = 0
        for (face, _, _) in currentRoll {
            let faceValue = face
            for die in currentDiceArray {
                let dieValue = die.faceValue
                if faceValue == dieValue && die.selected == true {
                    selectedDiceArray.append(currentDiceArray[dieID])
                }
                dieID += 1
            }
            faceID += 1
        }
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
    */}
}

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
