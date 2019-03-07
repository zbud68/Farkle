 import SpriteKit
 
        class Die: SKSpriteNode {
            
            var selected: Bool = false
            var faceValue: Int = Int()
            var pointValue: Int = Int()
            var scoringDie: Bool = false
            
        }
 
         class DieFaces {
            var faceValue: Int = 0
            var countThisRoll: Int = 0
         }
 
 var dieFace1: DieFaces = DieFaces()
 var dieFace2: DieFaces = DieFaces()
 var dieFace3: DieFaces = DieFaces()
 var dieFace4: DieFaces = DieFaces()
 var dieFace5: DieFaces = DieFaces()
 var dieFace6: DieFaces = DieFaces()
 
 var die1: Die = Die()
 var die2: Die = Die()
 var die3: Die = Die()
 var die4: Die = Die()
 var die5: Die = Die()
 var die6: Die = Die()

        let currentDiceRoll: [Die] = []
        
        var id = 0
        for die in currentDiceRoll {
            die.faceValue = Int(arc4random_uniform(6)+1)
            
            switch die.faceValue {
            case 1:
                die.texture = SKTexture(imageNamed: "Die1")
            case 2:
                die.texture = SKTexture(imageNamed: "Die2")
                dieFace2.countThisRoll += 1
            case 3:
                die.texture = SKTexture(imageNamed: "Die3")
                dieFace3.countThisRoll += 1
            case 4:
                die.texture = SKTexture(imageNamed: "Die4")
                dieFace4.countThisRoll += 1
            case 5:
                die.texture = SKTexture(imageNamed: "Die5")
                dieFace5.countThisRoll += 1
            case 6:
                die.texture = SKTexture(imageNamed: "Die6")
                dieFace6.countThisRoll += 1
            default:
                break
            }
            id += 1
        }

