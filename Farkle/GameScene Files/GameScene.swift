//
//  GameScene.swift
//  Farkle
//
//  Created by Mark Davis on 1/29/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

// MARK: ********** Global Variables Section **********

enum GameState {
    case NewGame, InProgress, NewRound, GameOver
}

/*
enum PlayerState {
    case SelectingDie, Idle, Rolling, FinalRoll, Finished
}
*/

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: ********** Class Variables Section **********
    
    let physicsContactDelegate = self

    //MARK: ********** Player Variables **********
    
    let player1: Player = Player.init(name: "Player 1", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false)
    let player2: Player = Player.init(name: "Player 2", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false)
    let player3: Player = Player.init(name: "Player 3", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false)
    let player4: Player = Player.init(name: "Player 4", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false)
    
    var currentPlayer: Player = Player(name: "Player 1", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false)
    var currentPlayerID: Int = 0

    var playersArray: [Player]!
 
    //MARK: ********* Dice Variables **********

    var dieFace1: DieFace = DieFace(faceValue: 1, pointValue: 10, scoringDie: true)
    var dieFace2: DieFace = DieFace(faceValue: 2, pointValue: 2, scoringDie: false)
    var dieFace3: DieFace = DieFace(faceValue: 3, pointValue: 3, scoringDie: false)
    var dieFace4: DieFace = DieFace(faceValue: 4, pointValue: 4, scoringDie: false)
    var dieFace5: DieFace = DieFace(faceValue: 5, pointValue: 5, scoringDie: true)
    var dieFace6: DieFace = DieFace(faceValue: 6, pointValue: 6, scoringDie: false)
    
    var die1: Die = Die()
    var die2: Die = Die()
    var die3: Die = Die()
    var die4: Die = Die()
    var die5: Die = Die()
    var die6: Die = Die()

    var diceArray: [Die] = [Die]()
    var selectedDice: [Die] = [Die]()
    var dieFacesArray: [DieFace] = [DieFace]()
    var dieFaces: [Int] = [Int]()

    var currentGame: Game = Game()
    var currentScore: Int = 0

    //MARK: ********** GameScene Variables **********
    
    var gameTable: SKSpriteNode = SKSpriteNode()
    var backGround: SKSpriteNode = SKSpriteNode()
    var mainMenu: SKSpriteNode = SKSpriteNode()
    var settingsMenu: SKSpriteNode = SKSpriteNode()
    var helpMenu: SKSpriteNode = SKSpriteNode()
    var mainMenuLabel: SKLabelNode = SKLabelNode()
    var settingsMenuLabel: SKLabelNode = SKLabelNode()
    var soundIconLabel: SKLabelNode = SKLabelNode()
    var backIconLabel: SKLabelNode = SKLabelNode()
    var newGameIconLabel: SKLabelNode = SKLabelNode()
    var settingsIconLabel: SKLabelNode = SKLabelNode()
    var resumeIconLabel: SKLabelNode = SKLabelNode()
    var exitIconLabel: SKLabelNode = SKLabelNode()
    var rollDiceIconLabel: SKLabelNode = SKLabelNode()
    var keepScoreIconLabel: SKLabelNode = SKLabelNode()
    var currentScoreLabel: SKLabelNode = SKLabelNode()

    var newGameIcon: SKSpriteNode = SKSpriteNode()
    var pauseIcon: SKSpriteNode = SKSpriteNode()
    var exitIcon: SKSpriteNode = SKSpriteNode()
    var soundIcon: SKSpriteNode = SKSpriteNode()
    var infoIcon: SKSpriteNode = SKSpriteNode()
    var menuIcon: SKSpriteNode = SKSpriteNode()
    var resumeIcon: SKSpriteNode = SKSpriteNode()
    var settingsIcon: SKSpriteNode = SKSpriteNode()
    var homeIcon: SKSpriteNode = SKSpriteNode()
    var backIcon: SKSpriteNode = SKSpriteNode()
    var rollDiceIcon: SKSpriteNode = SKSpriteNode()
    var keepScoreIcon: SKSpriteNode = SKSpriteNode()
    
    var iconWindow: SKSpriteNode = SKSpriteNode()
    var scoresWindow: SKSpriteNode = SKSpriteNode()
    
    var mainMenuIconsArray = [SKSpriteNode]()
    var settingsMenuIconsArray = [SKSpriteNode]()
    var iconWindowIconsArray = [SKSpriteNode]()

    let logo = SKLabelNode(text: "Farkle")
    let logo2 = SKLabelNode(text: "Plus")

    //MARK: ********** Touches Variables **********
    var touchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var currentTouch: UITouch = UITouch()
    var currentTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var iconWindowTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var gameTableTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var mainMenuTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var settingsMenuTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    
    var scoringCombo: ScoringCombo = ScoringCombo()
    
    var die1Position: CGPoint = CGPoint()
    var die2Position: CGPoint = CGPoint()
    var die3Position: CGPoint = CGPoint()
    var die4Position: CGPoint = CGPoint()
    var die5Position: CGPoint = CGPoint()
    var die6Position: CGPoint = CGPoint()
    
    var placeHolderWindow: SKSpriteNode = SKSpriteNode()
    var placeHolder: SKSpriteNode = SKSpriteNode()
    var placeHolderArray: [SKSpriteNode] = [SKSpriteNode]()
    var placeHolderLocations: [CGPoint] = [CGPoint]()
    var diePositions: [CGPoint] = [CGPoint]()
    var placeHolderTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    
    var die1_PlaceHolder = SKSpriteNode()
    var die2_PlaceHolder = SKSpriteNode()
    var die3_PlaceHolder = SKSpriteNode()
    var die4_PlaceHolder = SKSpriteNode()
    var die5_PlaceHolder = SKSpriteNode()
    var die6_PlaceHolder = SKSpriteNode()
    let offsetY = CGFloat(48)
    var firstRoll = true
    
    var currentDice: [Die] = [Die]()
    var rollableDice = [Die]()
    
    var currentDiePosition = CGPoint()
    var previousDiePosition = CGPoint()
    
    // MARK: ********** didMove Section **********
    override func didMove(to view: SKView) {
        var dieID = 0
        for _ in 1...6 {
            diePositions.append(CGPoint(x: 0, y: 0))
            dieID += 1
        }

        setupBackGround(isComplete: handlerBlock)
        setupGameTable(isComplete: handlerBlock)
        setupIconWindow(isComplete: handlerBlock)
        setupScoresWindow(isComplete: handlerBlock)
        displayGameTable(isComplete: handlerBlock)
        displayMainMenu(isComplete: handlerBlock)
        displaySettingsMenu(isComplete: handlerBlock)
        setupPlaceHolderWindow()
        setupDiePlaceHolders()
    }
    
    func displayGameTable(isComplete: (Bool) -> Void) {
        backGround.addChild(gameTable)
        gameTable.addChild(logo)
        logo.addChild(logo2)
        
        isComplete(true)
    }
    
    func displayMainMenu(isComplete: (Bool) -> Void) {
        mainMenu.texture = GameConstants.Textures.MainMenu
        mainMenu.name = "MainMenu"
        mainMenu.alpha = 1
        mainMenu.position = CGPoint(x: -35, y: 0)
        mainMenu.size = CGSize(width: frame.size.width / 2, height: frame.size.height / 1.5)
        mainMenu.zPosition = GameConstants.ZPositions.Menu
        if gameState == .NewGame {
            setupMainMenuIcons()
        }
        isComplete(true)
    }
    
    func displaySettingsMenu(isComplete: (Bool) -> Void) {
        settingsMenu.texture = GameConstants.Textures.SettingsMenu
        settingsMenu.name = "SettingsMenu"
        settingsMenu.position = CGPoint(x: 0, y: 0)
        settingsMenu.size = CGSize(width: frame.size.width / 2, height: frame.size.height / 1.5)
        settingsMenu.zPosition = GameConstants.ZPositions.Menu
        setupSettingsMenuIcons(isComplete: handlerBlock)
        isComplete(true)
    }

    // MARK: ********** Touches Section **********

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            iconWindowTouchLocation = touch.location(in: iconWindow)
            mainMenuTouchLocation = touch.location(in: mainMenu)
            settingsMenuTouchLocation = touch.location(in: settingsMenu)
            gameTableTouchLocation = touch.location(in: gameTable)
            placeHolderTouchLocation = touch.location(in: placeHolderWindow)
        }
        wasMainMenuIconTouched()
        wasSettingsMenuIconTouched()
        wasIconWindowIconTouched()
        wasDiceTouched()
    }
    
    func wasMainMenuIconTouched() {
        for icon in mainMenuIconsArray where icon.contains(mainMenuTouchLocation) {
            switch icon.name {
            case "New Game":
                newGameIconTouched()
            case "Continue":
                resumeIconTouched()
            case "Settings":
                settingsIconTouched()
            case "Exit":
                exitIconTouched()
            case "Info":
                infoIconTouched()
            default:
                break
            }
        }
    }
    
    func wasSettingsMenuIconTouched() {
        for icon in settingsMenuIconsArray where icon.contains(settingsMenuTouchLocation) {
            switch icon.name {
            case "Sound":
                soundIconTouched()
            case "Back":
                backIconTouched()
            default:
                break
            }
        }
    }
    
    func wasIconWindowIconTouched() {
        for icon in iconWindowIconsArray where icon.contains(iconWindowTouchLocation) {
            switch icon.name {
            case "Pause":
                pauseIconTouched()
            case "RollDice":
                currentDice = getNewDice()
                rollDice(isComplete: handlerBlock)
            case "KeepScore":
                keepScoreIconTouched()
            default:
                break
            }
        }
    }
    
    func wasDiceTouched() {
        touches: do {
            for die in currentDice where die.selected {
                die.physicsBody?.isDynamic = false
                die.selectable = false
            }
            
            //checkForAStraight(isComplete: handlerBlock)
            //checkForThreeOfAKind(isComplete: handlerBlock)
            
            for die in currentDice {
                if die.contains(placeHolderTouchLocation) {
                    if die.selected {
                        die.selected = false
                        die.texture = die.currentFace.unSelectedTexture
                        die.position = die.previousPosition
                        die.zRotation = 0
                        if die.currentFace.countThisRoll != 0 {
                            die.currentFace.countThisRoll -= 1
                        }
                    } else if !die.selected {
                        die.selected = true
                        selectedDice.append(die)
                        die.texture = die.currentFace.selectedTexture
                        die.position = die.diePosition
                        die.zRotation = 0
                        die.currentFace.countThisRoll += 1
                    }
                }
                dieFaces.append(die.currentFace.value)
            }
            
            dieFaces = dieFaces.sorted()
            
            if dieFaces == scoringCombo.lowStraight || dieFaces == scoringCombo.highStraight || dieFaces == scoringCombo.sixDieStraight {
                scoringCombo.straight = true
                for die in currentDice {
                    die.selected = true
                    die.position = die.diePosition
                    die.zRotation = 0
                    die.currentFace.countThisRoll = 0
                }
                currentPlayer.currentRollScore += currentScore
                break touches
            }

            
            for die in selectedDice where die.currentFace.countThisRoll >= 2 {
                switch die.currentFace.countThisRoll {
                case 2:
                    scoringCombo.pairs += 1
                case 3:
                    scoringCombo.threeOAK = true
                case 4:
                    scoringCombo.fourOAK = true
                case 5:
                    scoringCombo.fiveOAK = true
                case 6:
                    scoringCombo.sixOAK = true
                default:
                    break
                }
            }
            
            if scoringCombo.pairs == 1 && scoringCombo.threeOAK == true {
                scoringCombo.pairs -= 1
                scoringCombo.threeOAK = false
                scoringCombo.fullHouse = true
                break touches
            }
            
            for die in selectedDice where die.currentFace.countThisRoll == 1 {
                if die.currentFace.value == 1 {
                    currentScore += 100
                    die.currentFace.countThisRoll -= 1
                } else if die.currentFace.value == 5 {
                    currentScore += 50
                    die.currentFace.countThisRoll -= 1
                }
            }
        }
    }
    
    func checkForNewRoll() {
        if selectedDice.count >= currentGame.numDice {
            selectedDice.removeAll()
            for die in currentDice {
                die.selected = false
                die.selectable = true
                die.physicsBody?.isDynamic = true
            }
            startNewRoll()
        }

    }
    
    func setDieImage(die: Die) {
        if die.selected == true {
            die.texture = die.currentFace.selectedTexture
            die.physicsBody?.isDynamic = false
        } else {
            die.texture = die.currentFace.unSelectedTexture
            die.physicsBody?.isDynamic = true
        }
    }
    
    func newGameIconTouched() {
        /*
        if gameState == .InProgress {
            //displayGameInProgressWarning()
        } else {
        */
            showIconWindowIcons()
            gameTable.addChild(currentScoreLabel)
            fadeScoreLabel(isComplete: handlerBlock)
            setupNewGame()
        //}
    }
    
    func setupNewGame() {
        print("new game")
        getCurrentGameSettings()
        setupPlayers()
        currentPlayer = playersArray.first!
        currentPlayerID = 0
        currentPlayer.nameLabel.fontColor = GameConstants.Colors.PlayerNameLabelFont
        currentPlayer.scoreLabel.fontColor = GameConstants.Colors.PlayerScoreLabelFont
        getDice()
        setupDice()
    }
    
    func getCurrentGameSettings() {
        currentGame = Game()
    }
    
    func resumeIconTouched() {
        if gameState == .NewGame {
            //displayNoGameInProgreeMessage()
        } else {
            showIconWindowIcons()
        }
    }
    
    func settingsIconTouched() {
        if gameState == .InProgress {
            //displaySettingsChangeWillCancelCurrentGameWarning()
        } else {
            showSettingsMenu()
        }
    }
    
    func exitIconTouched() {
        if gameState == .InProgress {
            //displayExitGameWarning()
        } else {
            //displayConfirmationMessage()
            exit(0)
        }
    }
    
    func infoIconTouched() {
        //displayInfoWindow()
    }
    
    func soundIconTouched() {

    }
    
    func backIconTouched() {
        showMainMenu()
    }
    
    func pauseIconTouched() {
        if pauseIcon.isPaused != true {
            showMainMenu()
        }
    }
    
    func keepScoreIconTouched() {
        currentPlayer.score += currentScore
        currentPlayer.scoreLabel.text = String(currentPlayer.score)
        currentPlayer.currentRollScore = 0
        currentScore = 0
        nextPlayer()
    }
    
    func nextPlayer() {
        print("next player")
        firstRoll = true
        setupDice()
        currentPlayer.nameLabel.fontColor = UIColor.lightGray
        currentPlayer.scoreLabel.fontColor = UIColor.lightGray
        
        if currentPlayerID < playersArray.count - 1 {
            currentPlayerID += 1
            currentPlayer = playersArray[currentPlayerID]
        } else {
            currentPlayerID = 0
            startNewRound()
        }

        currentPlayer = playersArray[currentPlayerID]
        currentPlayer.nameLabel.fontColor = GameConstants.Colors.PlayerNameLabelFont
        currentPlayer.scoreLabel.fontColor = GameConstants.Colors.PlayerScoreLabelFont
        selectedDice.removeAll()
        currentPlayer.currentRollScore = 0
        currentScore = 0
        for die in rollableDice {
            die.physicsBody?.isDynamic = true
        }
    }
    
    func startNewRoll() {
        print("new roll")
        firstRoll = true
        currentDice = diceArray
        rollableDice = currentDice
        selectedDice.removeAll(keepingCapacity: true)
        resetVariables()
        for die in currentDice {
            //die.selected = false
            die.physicsBody?.isDynamic = true
            //setDieImage(die: die)
        }
        //setupDice()
        //positionDice(isComplete: handlerBlock)
        currentScore = 0
    }
    
    func startNewRound() {
        print("new round")
        firstRoll = true
        setupDice()
//        currentPlayer.currentRollScore += currentScore
        currentPlayer.scoreLabel.text = String(currentPlayer.currentRollScore)
        currentPlayer.nameLabel.fontColor = UIColor.lightGray
        currentPlayer.scoreLabel.fontColor = UIColor.lightGray
        currentPlayerID = 0
        for player in playersArray {
            player.currentRollScore = 0
        }
        for die in rollableDice {
            die.physicsBody?.isDynamic = true
        }
        currentScore = 0
        currentGame.numRounds += 1
    }
    
    func showMainMenu() {
        hideSettingMenu()
        hideIconWindowIcons()
        addMainMenu(isComplete: handlerBlock)
     }
    
    func hideMainMenu() {
        newGameIcon.removeAllChildren()
        resumeIcon.removeAllChildren()
        settingsIcon.removeAllChildren()
        exitIcon.removeAllChildren()
        infoIcon.removeAllChildren()
        mainMenu.removeAllChildren()
        mainMenu.removeFromParent()
    }
    
    func showSettingsMenu() {
        hideMainMenu()
        hideIconWindowIcons()
        addSettingsMenu(isComplete: handlerBlock)
    }
    
    func hideSettingMenu() {
        soundIcon.removeAllChildren()
        backIcon.removeAllChildren()
        settingsMenu.removeAllChildren()
        settingsMenu.removeFromParent()
    }
    
    func showIconWindowIcons() {
        hideMainMenu()
        hideSettingMenu()
        addIconWindowIcons(isComplete: handlerBlock)
        for icon in iconWindowIconsArray {
            icon.isPaused = false
        }
    }
    
    func hideIconWindowIcons() {
        iconWindow.removeAllChildren()
        for icon in iconWindowIconsArray {
            icon.isPaused = true
        }
    }
    
    func farkle() {
        print("Farkle")
        for die in rollableDice {
            print(die.currentFace.value)
        }
        print("next player")
        currentScore = 0
        currentPlayer.currentRollScore = 0
        currentPlayer.hasScoringDice = false
        nextPlayer()
        //showMessage(msg: "Farkle", isComplete: handlerBlock)
        
    }
    
    func showMessage(msg: String, isComplete: (Bool) -> Void) {
        if msg == "Farkle" {
            
        }
        isComplete(true)
    }
    
    func exitGame() {
        showMessage(msg: GameConstants.Messages.Winner, isComplete: handlerBlock)
        exit(0)
    }
    
    // MARK: ********** State Machine **********
    
    var gameState = GameState.NewGame {
        willSet {
            switch newValue {
            case .NewGame:
                setupNewGame()
            case .InProgress:
                showMessage(msg: GameConstants.Messages.GameInProgress, isComplete: handlerBlock)
            case .NewRound:
                startNewRound()
            case .GameOver:
                showMessage(msg: GameConstants.Messages.GameOver, isComplete: handlerBlock)
                exitGame()
            }
        }
    }
    
    let handlerBlock: (Bool) -> Void = {
        if $0 {
            var finished = false
            finished.toggle()
        }
    }
    
    // MARK: ********** Updates Section **********
    
    override func update(_ currentTime: TimeInterval) {
      currentScoreLabel.text = "\(currentPlayer.name) score: \(currentPlayer.currentRollScore)"

    }
}
