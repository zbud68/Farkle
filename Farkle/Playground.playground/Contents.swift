import PlaygroundSupport
import SpriteKit

class DieFaces {
    var faceName: String
    var faceValue: Int
    var pointValue: Int
    var countThisRoll: Int
    var scoringDie: Bool
    
    init(name: String, faceValue: Int, pointValue: Int, countThisRoll: Int, scoringDie: Bool)
    {
        self.faceName = name
        self.faceValue = faceValue
        self.pointValue = pointValue
        self.countThisRoll = countThisRoll
        self.scoringDie = false
    }
}

class ScoringCombo {
    var scoringDice = false
    var pairs = 0
    var threeOfAKind = false
    var threePair = false
    var straight = false
    var fullHouse = false
    var fourOfAKind = false
    var fiveOfAKind = false
    var sixOfAKind = false
}

class Player {
    var name: String
    let nameLabel: SKLabelNode = SKLabelNode()
    let scoreLabel: SKLabelNode = SKLabelNode()
    
    var score: Int
    var currentRollScore: Int
    var hasScoringDice: Bool
    var isRolling: Bool
    var isSelectingDice: Bool
    var lastRoll: Bool
    var finished: Bool
    var farkle: Bool
    
    init(name: String, score: Int, currentRollScore: Int, hasScoringDice: Bool, isRolling: Bool, isSelectingDice: Bool, lastRoll: Bool, finished: Bool, farkle: Bool)
    {
        self.name = name
        self.score = score
        self.currentRollScore = currentRollScore
        self.hasScoringDice = hasScoringDice
        self.isRolling = isRolling
        self.isSelectingDice = isSelectingDice
        self.lastRoll = lastRoll
        self.finished = finished
        self.farkle = farkle
    }
}

class GameScene: SKScene {
    
    var player: Player!
    
    var player1 = Player.init(name: "Player 1", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false, farkle: false)
    
    var player2 = Player.init(name: "Player 2", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false, farkle: false)

    var currentRoll: [(Int, Int, Int)] = [(Int, Int, Int)]()
    var dieFacesArray: [DieFaces] = []
    var pairs: Int = 0
    var scoreMultiplier: Int = 1
    
    var scoringCombo: ScoringCombo = ScoringCombo.init()
    
    
    /*
     var scoringCombo: ScoringCombo = ScoringCombo.init(scoringDice: false, pairs: 0, threeOfAKind: false, threePair: false, straight: false, fullHouse: false, fourOfAKind: false, fiveOfAKind: false, sixOfAKind: false)
     */
    
    let lowStraight = [1,2,3,4,5]
    let highStraight = [2,3,4,5,6]
    let sixDieStraight = [1,2,3,4,5,6]

    var faceValues: [Int] = [Int]()
    var pointValues: [Int] = [Int]()
    var dieCount: [Int] = [Int]()

    override func didMove(to view: SKView) {
        rollDice()
        getCount()
        checkForAStraight()
        checkForThreeOfAKind()
    }
    
    func rollDice() {
        var id = 0
        for _ in 1...6 {
            let currentDie = Int(arc4random_uniform(6)+1)
            currentRoll[id].0 = currentDie
            if currentDie == 1 {
                currentRoll[id].1 = currentDie * 10
            } else {
                currentRoll[id].1 = currentDie
            }
            currentRoll[id].2 = 0
            id += 1
        }
        print(currentRoll)
    }
    
    func getCount() {
        var id = 0
        for (face, _, _) in currentRoll {
            let faceValue = face
            //var pointValue = point
            //var dieCount = count
            
            switch faceValue {
            case 1:
                currentRoll[id].2 += 1
                break
            case 2:
                currentRoll[id].2 += 1
                break
            case 3:
                currentRoll[id].2 += 1
                break
            case 4:
                currentRoll[id].2 += 1
                break
            case 5:
                currentRoll[id].2 += 1
                break
            case 6:
                currentRoll[id].2 += 1
                break
            default:
                break
            }
            print(currentRoll[id].2)
            id += 1
        }
    }
    
    func checkForAStraight() {

        var id = 0
        for _ in currentRoll {
            faceValues.append(currentRoll[id].0)
            pointValues.append(currentRoll[id].1)
            dieCount.append(currentRoll[id].2)
            
            id += 1
        }
        
        for dieFace in dieFacesArray {
            faceValues.append(dieFace.faceValue)
            faceValues = faceValues.sorted()
        }
        if faceValues == sixDieStraight {
            scoringCombo.straight = true
            print("six die straight")
        } else if faceValues == lowStraight || faceValues == highStraight {
            scoringCombo.straight = true
            print("straight")
        }
    }
    
    func checkForThreeOfAKind() {
        let currentPlayer = player1
        
        var id = 0
        for (_, point, count) in currentRoll {
            let currentDie = currentRoll[id]
            
            //let faceValue = face
            let pointValue = point
            let dieCount = count
            
            print("current Die \(currentDie.0), face value \(currentDie.0)")
            switch dieCount {
            case 1:
                currentPlayer.currentRollScore += pointValue * 100
                if pointValue == 1 {
                    scoringCombo.scoringDice = true
                    currentPlayer.currentRollScore += 100
                    print("scoring die")
                } else if pointValue == 5 {
                    scoringCombo.scoringDice = true
                    currentPlayer.currentRollScore += 100
                    print("scoring die")
                }
            case 2:
                scoringCombo.pairs += 1
                if scoringCombo.pairs > 2 {
                    scoringCombo.threePair = true
                }
            case 3:
                scoringCombo.threeOfAKind = true
            case 4:
                scoringCombo.fourOfAKind = true
            case 5:
                scoringCombo.fiveOfAKind = true
            case 6:
                scoringCombo.sixOfAKind = true
            default:
                break
            }
            id += 1
        }
    }
    
    func whatchaGot() {

    }
}
        /*
        for (combo, value) in scoringCombo {
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
    } */




