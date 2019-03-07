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
    
    let player1: Player = Player.init(name: "Player 1", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false, farkle: false)
    let player2: Player = Player.init(name: "Player 2", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false, farkle: false)
    let player3: Player = Player.init(name: "Player 3", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false, farkle: false)
    let player4: Player = Player.init(name: "Player 4", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false, farkle: false)
    
    var currentPlayer: Player = Player(name: "Player 1", score: 0, currentRollScore: 0, hasScoringDice: false, isRolling: false, isSelectingDice: false, lastRoll: false, finished: false, farkle: false)
    var currentPlayerID: Int = 0

    var playersArray: [Player]!
 
    //MARK: ********* Dice Variables **********

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

    var currentDiceArray: [Die] = [Die]()
    var selectedDiceArray: [Die] = [Die]()
    var dieFacesArray: [DieFaces] = [DieFaces]()

    var currentGame: Game = Game()
    var currentRoll: [(Int, Int, Int)] = [(face: Int, point: Int, count: Int)]()
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
    var scoringDiceFaceValue: Int = 0
    
    var dieTextures: [[SKTexture:SKTexture]] = [[:]]
    
    // MARK: ********** didMove Section **********
    override func didMove(to view: SKView) {

        setupBackGround(isComplete: handlerBlock)
        setupGameTable(isComplete: handlerBlock)
        setupIconWindow(isComplete: handlerBlock)
        setupScoresWindow(isComplete: handlerBlock)
        displayGameTable(isComplete: handlerBlock)
        displayMainMenu(isComplete: handlerBlock)
        displaySettingsMenu(isComplete: handlerBlock)
        getDice()
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
        mainMenu.position = CGPoint(x: 0, y: 0)
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
                rollDice()
            case "KeepScore":
                keepScoreIconTouched()
            default:
                break
            }
        }
    }
    
    func wasDiceTouched() {
        
        var id = 0
        for die in currentDiceArray {
            if die.contains(gameTableTouchLocation) {
                die.selected = true
                selectedDiceArray.append(die)
            } else {
                //currentDiceArray.remove(at: id)
            
            }
            id += 1
        }
        print("selected die: \(selectedDiceArray)")
        whatchaGot(isComplete: handlerBlock)
    }

    func newGameIconTouched() {
        if gameState == .InProgress {
            //displayGameInProgressWarning()
        } else {
            showIconWindowIcons()
            gameTable.addChild(currentScoreLabel)
            fadeScoreLabel(isComplete: handlerBlock)
            //gameState = .NewGame
            setupNewGame()
        }
        //getDice()
    }
    
    func setupNewGame() {
        getCurrentGameSettings()
        setupPlayers()
        currentPlayer = playersArray.first!
        currentPlayerID = 0
        currentPlayer.nameLabel.fontColor = GameConstants.Colors.PlayerNameLabelFont
        currentPlayer.scoreLabel.fontColor = GameConstants.Colors.PlayerScoreLabelFont
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
        printScore(label: "keepScoreTouched", currentP: currentPlayer.currentRollScore, currentS: currentScore)
        currentPlayer.currentRollScore += currentScore
        currentPlayer.score += currentPlayer.currentRollScore
        currentPlayer.scoreLabel.text = String(currentPlayer.score)
        currentPlayer.currentRollScore = 0
        currentScore = 0
        nextPlayer()
    }
    
    func nextPlayer() {
        currentPlayer.nameLabel.fontColor = UIColor.lightGray
        currentPlayer.scoreLabel.fontColor = UIColor.lightGray
        
        if currentPlayerID < playersArray.count - 1 {
            currentPlayerID += 1
            currentPlayer = playersArray[currentPlayerID]
        } else {
            currentPlayerID = 0
            gameState = .NewRound
        }

        currentPlayer = playersArray[currentPlayerID]
        currentPlayer.nameLabel.fontColor = GameConstants.Colors.PlayerNameLabelFont
        currentPlayer.scoreLabel.fontColor = GameConstants.Colors.PlayerScoreLabelFont
        setupDice()
        selectedDiceArray.removeAll()
        //resetDice()
        //repositionDice()
        currentPlayer.currentRollScore = 0
        currentScore = 0
        for die in currentDiceArray {
            die.physicsBody?.isDynamic = true
        }
    }
    
    func startNewRoll() {
        currentPlayer.currentRollScore += currentScore
        setupDice()
        currentScore = 0
        //zeroOutDieCount()
        //currentDiceArray = defaultDiceArray
        currentPlayer.hasScoringDice = false

        for die in currentDiceArray {
            die.selected = false
            die.physicsBody?.isDynamic = true
        }
        //repositionDice()
    }
    
    func startNewRound() {
        currentScore = 0
        currentPlayer.nameLabel.fontColor = UIColor.lightGray
        currentPlayer.scoreLabel.fontColor = UIColor.lightGray
        currentPlayerID = 0
        for player in playersArray {
            player.currentRollScore = 0
        }
        for die in currentDiceArray {
            die.physicsBody?.isDynamic = true
        }
        currentGame.numRounds += 1
        setupDice()
        //resetDice()
        //repositionDice()
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
        currentScore = 0
        currentPlayer.currentRollScore = 0
        showMessage(msg: "Farkle", isComplete: handlerBlock)
        resetCurrentPlayer()
        nextPlayer()
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
    
    /*
    var playerState = PlayerState.Idle {
        willSet {
            switch newValue {
            case .SelectingDie:
                print("selecting die")
            case .Idle:
                print("player state: \(playerState)")
            case .Rolling:
                rollDice(isComplete: handlerBlock)
            case .Finished:
                print("Player has finished")
            //currentPlayer.finished = true
            case .FinalRoll:
                print("Player has one final roll")
            //currentPlayer.finalRoll = true
            }
        }
    }
    */
    
    func printScore(label: String, currentP: Int, currentS: Int) {
        print("From: \(label)\nCurrentPlayer: \(currentPlayer.currentRollScore)\nCurrentScore: \(currentScore)")
    }
    
    let handlerBlock: (Bool) -> Void = {
        if $0 {
            var finished = false
            finished.toggle()
            //print("finished handler block")
        }
    }
    
    // MARK: ********** Updates Section **********
    
    override func update(_ currentTime: TimeInterval) {
      currentScoreLabel.text = "\(currentPlayer.name) score: \(currentScore)"

    }
}
