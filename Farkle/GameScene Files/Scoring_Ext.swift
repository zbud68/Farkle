//
//  Scoring_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 3/1/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    func resetVariables() {
        /*
        for die in diceArray {
            die.selected = false
            die.selectable = true
        }
        */
        for face in dieFaces {
            var currentFace = face
            currentFace.countThisRoll = 0
        }
        
        scoringCombo.pairs = 0
        scoringCombo.threeOAK = false
        scoringCombo.threePair = false
        scoringCombo.straight = false
        scoringCombo.fullHouse = false
        scoringCombo.fourOAK = false
        scoringCombo.fiveOAK = false
        scoringCombo.sixOAK = false
    }
    
    func rollDice(isComplete: (Bool) -> Void) {
        
        var currentDice = [Die]()
        for die in diceArray {
            if die.selected == true {
                die.selectable = false
                die.physicsBody?.isDynamic = false
                selectedDice = diceArray.filter { $0.selected == true }
                currentDice = diceArray.filter { $0.selectable == true }
            }
        }
        
        diceArray = getNewDice()
        currentDice.removeAll()
        currentDice = diceArray
        for die in currentDice {
            if die.selected == true {
                die.physicsBody?.isDynamic = false
            } else {
                animateDice(die: die, isComplete: handlerBlock)
            }
        }
        for die in currentDice {
            if die.currentFace.scoringDie == true {
                scoringCombo.scoringDice = true
            }
        }
        if scoringCombo.scoringDice == false {
            farkle()
        }
        
        //var currentScore = 0

        //currentScore = tallyTheScore(dice: currentDice)
        currentScoreLabel.text = String(currentScore)
        resetVariables()
        isComplete(true)
    }
    
    func getNewDice() -> [Die] {
        let currentDice = diceArray
        
        for die in diceArray where !die.selected {
            let currentFace = Int(arc4random_uniform(6)+1)
            die.currentFace = dieFaces[currentFace - 1]
            die.currentFace.countThisRoll += 1
            
            /*
            switch currentFace {
            case 1:
                die.currentFace = dieFace1
                dieFaces[currentFace - 1].countThisRoll += 1
            case 2:
                die.currentFace = dieFace2
                dieFaces[1].countThisRoll += 1
            case 3:
                die.currentFace = dieFace3
                dieFaces[2].countThisRoll += 1
            case 4:
                die.currentFace = dieFace4
                dieFaces[3].countThisRoll += 1
            case 5:
                die.currentFace = dieFace5
                dieFaces[4].countThisRoll += 1
            case 6:
                die.currentFace = dieFace6
                dieFaces[5].countThisRoll += 1
            default:
                break
            }
            */
            
            setDieImage(die: die)
        }
        return currentDice
    }
    
    func tallyTheScore(dice: [Die], rollScore: Int) -> Int {
        var currentRollScore = rollScore
        currentRollScore += checkForAStraight(rollScore: currentRollScore)
        currentRollScore += checkForThreeOfAKind(score: currentRollScore)
        
        //let currentDice = dice
        
        /*
        for die in currentDice where die.selected == true {
            if die.faceValue == 1 {
                print("Adding 100 points to score from tallyScore for getting a 1")
                currentScore += 100
                scoringCombo.scoringDice = true
            } else if die.faceValue == 5 {
                print("Adding 50 points to score from tallyScore for getting a 5")
                currentScore += 50
                scoringCombo.scoringDice = true
            }
        }
        */
        currentRollScore += checkForThreeOfAKind(score: currentRollScore)
        return currentRollScore
    }

    func checkForAStraight(rollScore: Int) -> Int{
        
        var currentRollScore = rollScore

        let currentDice = diceArray
        
        var dieFaces: [Int] = []
        for die in currentDice {
            dieFaces.append(die.currentFace.value)
        }
        dieFaces = dieFaces.sorted()
        
        if dieFaces == scoringCombo.sixDieStraight || dieFaces == scoringCombo.highStraight || dieFaces == scoringCombo.lowStraight {
            scoringCombo.straight = true
            currentRollScore += 1500
            startNewRoll()
        }
        return currentRollScore
    }

    func checkForThreeOfAKind(score: Int) -> Int {
        //let currentDice = diceArray
        
        //var currentRollScore = score
    
        for die in diceArray where die.selected {
            switch die.currentFace.countThisRoll {
            case 2:
                scoringCombo.pairs += 1
                if die.currentFace.value == 1 {
                    scoringCombo.scoringDice = true
                    currentScore += 200
                } else if die.currentFace.value == 5 {
                    scoringCombo.scoringDice = true
                    currentScore += 100
                }
                die.currentFace.countThisRoll -= 2

            case 6:
                scoringCombo.sixOAK = true
                currentScore += (die.currentFace.points * 100) * (die.currentFace.countThisRoll - 2)
                startNewRoll()
            case 5:
                scoringCombo.fiveOAK = true
                currentScore += (die.currentFace.points * 100) * (die.currentFace.countThisRoll - 2)
                if currentGame.numDice == 5 {
                    startNewRoll()
                }
            case 4:
                scoringCombo.fourOAK = true
                currentScore += (die.currentFace.points * 100) * (die.currentFace.countThisRoll - 2)

            case 3:
                if currentGame.numDice == 5 {
                    if scoringCombo.pairs == 1 {
                        scoringCombo.fullHouse = true
                        currentScore += 750
                        startNewRoll()
                    }
                } else {
                    scoringCombo.threeOAK = true
                    currentScore += (die.currentFace.points * 100) * (die.currentFace.countThisRoll - 2)
                }
            case 1:
                if die.currentFace.value == 1 {
                    scoringCombo.scoringDice = true
                    currentScore += 100
                } else if die.currentFace.value == 5 {
                    scoringCombo.scoringDice = true
                    currentScore += 50
                }
                die.currentFace.countThisRoll -= 1
            default:
                break
            }
        }
        return currentScore
    }
}

        
    /*
        
        for dieFace in dieFacesArray {
            if dieFace.countThisRoll == 2 {
                scoringCombo.pairs += 1
            }
        }
    
        var dieID = 0
        for dieFace in dieFacesArray {
            let dieCount = dieFace.countThisRoll
            let faceValue = dieFace.faceValue
            
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
                break
            case 3:
                scoringCombo.threeOAK = true
                scoringCombo.scoringDice = true
                scoringDiceFaceValue = faceValue
                print("Adding points to score from checkFor3OAK for getting 3OAK")
                currentRollScore += faceValue * 100
                break
            case 4:
                scoringCombo.fourOAK = true
                scoringCombo.scoringDice = true
                scoringDiceFaceValue = faceValue
                print("Adding points to score from checkFor3OAK for getting 4OAK")
                currentRollScore += (faceValue * 100) * 2
                break
            case 5:
                scoringCombo.fiveOAK = true
                scoringCombo.scoringDice = true
                scoringDiceFaceValue = faceValue
                print("Adding points to score from checkFor3OAK for getting 5OAK")
                currentRollScore += (faceValue * 100) * 3
               break
            case 6:
                scoringCombo.sixOAK = true
                scoringCombo.scoringDice = true
                scoringDiceFaceValue = faceValue
                print("Adding points to score from checkFor3OAK for getting 6OAK")
                currentRollScore += (faceValue * 100) * 4
              break
            default:
                break
            }
            if currentGame.numDice == 5 {
                if scoringCombo.threeOAK == true && scoringCombo.pairs == 1 {
                    scoringCombo.fullHouse = true
                    scoringCombo.threeOAK = false
                    scoringCombo.scoringDice = true
                    print("Adding points to score from checkFor3OAK for getting s fullHouse")
                    currentRollScore += 750
                }
            }
            
            if scoringCombo.pairs == 3 {
                scoringCombo.threePair = true
                scoringCombo.scoringDice = true
                print("Adding points to score from checkFor3OAK for getting 3 pairs")
                currentRollScore += 500
            }
            dieID += 1
        }
        print("scoring dice: \(scoringCombo.scoringDice)")
        if firstRoll != true {
            if scoringCombo.scoringDice == false {
                print("farkle")
                farkle()
            }
            firstRoll = false
        }
        //whatchaGot(isComplete: handlerBlock)
        print("selected die count: \(selectedDice.count)")
        print("current die count: \(currentDice.count)")

    */
    
    /*
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
    */
    
/*
    func whatchaGot(isComplete: (Bool) -> Void) {
        for die in selectedDiceArray {
            let faceValue = die.faceValue
            let pointValue = die.pointValue

            var count = 0

            for dieFace in dieFacesArray {
                count = dieFace.countThisRoll
            }
            
            switch count {
            case 1:
                if faceValue == 1 || faceValue == 5 {
                    currentScore += pointValue * 10
                    print("currentScore: \(currentScore)")
                }
            case 2:
                if faceValue == 1 || faceValue == 5 {
                    currentScore += pointValue * 10
                    print("currentScore: \(currentScore)")
                }
            case 3:
                if scoringCombo.threeOAK == true {
                    currentScore += (pointValue * 100)
                    print("currentScore: \(currentScore)")
                }
            case 4:
                if scoringCombo.fourOAK == true {
                    currentScore += (pointValue * 100) * 2
                    print("currentScore: \(currentScore)")
                }
            case 5:
                if scoringCombo.fiveOAK == true {
                    currentScore += (pointValue * 100) * 3
                    print("currentScore: \(currentScore)")
                }
            case 6:
                if scoringCombo.sixOAK == true {
                    currentScore += (pointValue * 100) * 4
                    print("currentScore: \(currentScore)")
                }
            default:
                break
            }
            if scoringCombo.straight == true {
                currentScore += 1500
                print("currentScore: \(currentScore)")
                startNewRoll()
            } else if scoringCombo.fullHouse == true {
                if currentGame.numDice == 5 {
                    currentScore += 750
                    print("currentScore: \(currentScore)")
                    startNewRoll()
                }
            }
            if currentGame.numDice == 6 && scoringCombo.threePair == true {
                currentScore += 500
                print("currentScore: \(currentScore)")
                startNewRoll()
            }
            currentPlayer.currentRollScore += currentScore
            currentScoreLabel.text = String(currentScore)
            currentScore = 0
        }
        isComplete(true)
    }*/



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