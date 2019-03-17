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
        
        print("reset variables")
        for dieFace in dieFacesArray {
            dieFacesArray[dieFace.value - 1].countThisRoll = 0
        }
        for player in playersArray {
            player.currentRollScore = 0
            player.farkle = false
            player.finished = false
            player.hasScoringDice = false
            player.isRolling = false
            player.isSelectingDice = false
            player.lastRoll = false
        }
        
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
    
    func getNewDice() -> [Die] {
        print("new dice")
        
        for die in currentDice where !die.selected {
            currentDie = die
            //die.currentFace.countThisRoll = 0
            let currentFace = Int(arc4random_uniform(6)+1)
            var faceCount = dieFacesArray[currentFace - 1].countThisRoll
            let currentDieFace = dieFacesArray[currentFace - 1]
            
            currentDie.currentFace = currentDieFace
            faceCount += 1
        }
        
        for dieFace in dieFacesArray { //where !die.selected {
            print("dieCount \(dieFacesArray[dieFace.value - 1].countThisRoll)")
        }
        return currentDice
    }
    
    func rollDice(isComplete: (Bool) -> Void) {
        for dieFace in dieFacesArray {
            var face = dieFace
            face.countThisRoll = 0
        }
        
        for die in currentDice {
            currentDie = die
            if currentDie.selected {
                selectedDice.append(currentDie)
                currentDie.selectable = false
            }
        }
        currentDice = getNewDice()

        print("roll dice")
        currentScore = 0
        
        for die in currentDice where !die.selected {
            currentDie = die
            animateDice(die: currentDie, isComplete: handlerBlock)
        }
        
        if !firstRoll {
            tallyTheScore()
        }
    }
    
    func checkForFarkle(dice: [Die], isComplete: (Bool) -> Void) {
        if scoringCombo.straight || scoringCombo.fullHouse || scoringCombo.threePair || scoringCombo.threeOAK || scoringCombo.fourOAK || !scoringCombo.fiveOAK || scoringCombo.sixOAK || !scoringCombo.scoringDice {

            currentPlayer.hasScoringDice = true
        } else {
            currentPlayer.hasScoringDice = false
        }
        isComplete(true)
    }
    
    func tallyTheScore() {
        print("tally score")
        if scoringCombo.threeOAK == true {
            currentPlayer.hasScoringDice = true
            for die in currentDice {
                currentDie = die
                if currentDie.selected {
                    if dieFacesArray[die.currentFace.value - 1].countThisRoll == 3 {
                        currentScore += currentDie.currentFace.points * 100
                    }
                }
            }
        } else if scoringCombo.fourOAK == true {
            currentPlayer.hasScoringDice = true
            for die in currentDice where dieFacesArray[die.currentFace.value - 1].countThisRoll == 4 {
                currentDie = die
                if currentDie.selected {
                    currentScore += (currentDie.currentFace.points * 100) * 2
                }
            }
        } else if scoringCombo.fiveOAK == true {
            currentPlayer.hasScoringDice = true
           for die in currentDice where     dieFacesArray[die.currentFace.value - 1].countThisRoll == 5     {
                currentDie = die
                if currentDie.selected {
                    currentScore += (currentDie.currentFace.points * 100) * 3
                }
            }
        } else if scoringCombo.sixOAK == true {
            currentPlayer.hasScoringDice = true
           for die in currentDice where dieFacesArray[die.currentFace.value - 1].countThisRoll == 6 {
                currentDie = die
                if currentDie.selected {
                    currentScore += (currentDie.currentFace.points * 100) * 4
                }
            }
        } else if scoringCombo.straight == true {
            currentPlayer.hasScoringDice = true
            currentScore += 1500
            startNewRoll()
        } else if scoringCombo.threeOAK == true && scoringCombo.pairs == 1 {
            currentPlayer.hasScoringDice = true
            currentScore += 750
        } else if scoringCombo.pairs == 3 {
            currentPlayer.hasScoringDice = true
            currentScore += 500
        } else if scoringCombo.scoringDice == false {
            for die in currentDice where die.currentFace.value == 1 || die.currentFace.value == 5 {
                currentDie = die
                                
                if currentDie.selected {
                    if currentDie.currentFace.value == 1 {
                        currentPlayer.hasScoringDice = true
                        currentScore += 100
                    } else if currentDie.currentFace.value == 5 {
                        if currentDie.selected {
                            currentPlayer.hasScoringDice = true
                            currentScore += 50
                        }
                    }
                }
            }
        }
        
        checkForFarkle(dice: currentDice, isComplete: handlerBlock)
        if currentPlayer.hasScoringDice == false {
            farkle()
        }
    }

    func checkForAStraight(isComplete: (Bool) -> Void) {
        print("check for straight")
        var dieFaces: [Int] = []
        for die in currentDice {
            currentDie = die
            dieFaces.append(currentDie.currentFace.value)
        }
        dieFaces = dieFaces.sorted()
        
        if dieFaces == scoringCombo.sixDieStraight || dieFaces == scoringCombo.highStraight || dieFaces == scoringCombo.lowStraight {
            scoringCombo.straight = true
        }
        isComplete(true)
    }

    func checkForThreeOfAKind(isComplete: (Bool) -> Void) {
        print("check for 3oak")
        for die in currentDice where die.selected {
            currentDie = die
            let count = dieFacesArray[die.currentFace.value - 1].countThisRoll
            currentDie = die
            
            switch count {
            case 6:
                scoringCombo.sixOAK = true
            case 5:
                scoringCombo.fiveOAK = true
            case 4:
                scoringCombo.fourOAK = true
            case 3:
                scoringCombo.threeOAK = true
            default:
                break
            }
        }
        isComplete(true)
    }
    
    func checkForOtherScoringDice(isComplete: (Bool) -> Void) {
        
        
        isComplete(true)
    }
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
