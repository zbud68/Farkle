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

enum PlayerState {
    case Idle, Rolling, FinalRoll, Finished, Farkle, NewRoll
}

let handlerBlock: (Bool) -> Void = {
    if $0 {
        var finished = false
        finished = true
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {

    // MARK: ********** Class Variables Section **********

    var rollAction = SKAction()
    
    let player1: Player = Player.init(score: 0, currentRollScore: 0, hasScoringDice: false)
    let player2: Player = Player.init(score: 0, currentRollScore: 0, hasScoringDice: false)
    let player3: Player = Player.init(score: 0, currentRollScore: 0, hasScoringDice: false)
    let player4: Player = Player.init(score: 0, currentRollScore: 0, hasScoringDice: false)
    
    let dieFace1: dieFaceDef = dieFaceDef.init(name: "DieFace1", faceValue: 1, points: 100, scoring: true)
    let dieFace2: dieFaceDef = dieFaceDef.init(name: "DieFace2", faceValue: 2, points: 0, scoring: false)
    let dieFace3: dieFaceDef = dieFaceDef.init(name: "DieFace3", faceValue: 3, points: 0, scoring: false)
    let dieFace4: dieFaceDef = dieFaceDef.init(name: "DieFace4", faceValue: 4, points: 0, scoring: false)
    let dieFace5: dieFaceDef = dieFaceDef.init(name: "DieFace5", faceValue: 5, points: 50, scoring: true)
    let dieFace6: dieFaceDef = dieFaceDef.init(name: "DieFace6", faceValue: 6, points: 0, scoring: false)
    
    var die1: Die = Die()
    var die2: Die = Die()
    var die3: Die = Die()
    var die4: Die = Die()
    var die5: Die = Die()
    var die6: Die = Die()
    
    var currentScore: Int = 0
    var currentGame: Game = Game()
    var currentPlayer: Player!
    var currentPlayerID: Int = 0

    var remainingDice: Int = 0

    var diceArray: [Die] = [Die]()
    var unSelectedTextures: [SKTexture] = [GameConstants.Textures.Die1, GameConstants.Textures.Die2, GameConstants.Textures.Die3, GameConstants.Textures.Die4, GameConstants.Textures.Die5, GameConstants.Textures.Die6]
    var selectedTextures: [SKTexture] = [GameConstants.Textures.Die1Selected, GameConstants.Textures.Die2Selected, GameConstants.Textures.Die3Selected, GameConstants.Textures.Die4Selected, GameConstants.Textures.Die5Selected, GameConstants.Textures.Die6Selected]
    var dieFaceArray: [dieFaceDef]!
    var currentDiceArray: [Die] = [Die]()
    var selectedDiceArray: [Die] = [Die]()
    var playersArray: [Player]!
    var currentRoll: [Int] = [Int]()
    
    let lowStraight: [Int] = [1,2,3,4,5]
    let highStraight: [Int] = [2,3,4,5,6]
    let sixDieStraight: [Int] = [1,2,3,4,5,6]
    
    var straight: Bool = false
    var threeOfAKind: Bool = false
    var threeOfAKind_2: Bool = false
    var fourOfAKind: Bool = false
    var fiveOfAKind: Bool = false
    var sixOfAKind: Bool = false
    var threePairs: Bool = false
    var fullHouse: Bool = false
    var scoringCombo = false

    let logo = SKLabelNode(text: "Farkle")
    let logo2 = SKLabelNode(text: "Plus")
    
    var mainMenuHolder: SKNode = SKNode()
    var settingsMenuHolder: SKNode = SKNode()
    var iconWindowIconsHolder: SKNode = SKNode()
    var gameTableHolder: SKNode = SKNode()
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

    var touchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var currentTouch: UITouch = UITouch()
    var currentTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var iconWindowTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var gameTableTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var mainMenuTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var settingsMenuTouchLocation: CGPoint = CGPoint(x: 0, y: 0)

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
    var iconTouched: String = String("")
    var rollDiceIcon: SKSpriteNode = SKSpriteNode()
    var keepScoreIcon: SKSpriteNode = SKSpriteNode()
    
    var iconWindow: SKSpriteNode = SKSpriteNode()
    var scoresWindow: SKSpriteNode = SKSpriteNode()
    
    var mainMenuIconsArray = [SKSpriteNode]()
    var settingsMenuIconsArray = [SKSpriteNode]()
    var iconWindowIconsArray = [SKSpriteNode]()
    
    var selfMaxX: CGFloat = CGFloat(0)
    var selfMinX: CGFloat = CGFloat(0)
    var selfMaxY: CGFloat = CGFloat(0)
    var selfMinY: CGFloat = CGFloat(0)
    var selfWidth: CGFloat = CGFloat(0)
    var selfHeight: CGFloat = CGFloat(0)

    var backGroundMaxX: CGFloat = CGFloat(0)
    var backGroundMinX: CGFloat = CGFloat(0)
    var backGroundMaxY: CGFloat = CGFloat(0)
    var backGroundMinY: CGFloat = CGFloat(0)
    var backGroundWidth: CGFloat = CGFloat(0)
    var backGroundHeight: CGFloat = CGFloat(0)

    var gameTableMaxX: CGFloat = CGFloat(0)
    var gameTableMinX: CGFloat = CGFloat(0)
    var gameTableMaxY: CGFloat = CGFloat(0)
    var gameTableMinY: CGFloat = CGFloat(0)
    var gameTableWidth: CGFloat = CGFloat(0)
    var gameTableHeight: CGFloat = CGFloat(0)

    var iconWindowMaxX: CGFloat = CGFloat(0)
    var iconWindowMinX: CGFloat = CGFloat(0)
    var iconWindowMaxY: CGFloat = CGFloat(0)
    var iconWindowMinY: CGFloat = CGFloat(0)
    var iconWindowWidth: CGFloat = CGFloat(0)
    var iconWindowHeight: CGFloat = CGFloat(0)

    var iconWidth: CGFloat = CGFloat(0)
    var iconHeight: CGFloat = CGFloat(0)

    var scoresWindowMaxX: CGFloat = CGFloat(0)
    var scoresWindowMinX: CGFloat = CGFloat(0)
    var scoresWindowMaxY: CGFloat = CGFloat(0)
    var scoresWindowMinY: CGFloat = CGFloat(0)
    var scoresWindowWidth: CGFloat = CGFloat(0)
    var scoresWindowHeight: CGFloat = CGFloat(0)

    let physicsContactDelegate = self
    
    var currentDie: Die = Die()
    
    var currentDieTexture: SKTexture = SKTexture()
    
    var unSelectedTexture: SKTexture = SKTexture()
    var selectedTexture: SKTexture = SKTexture()

    var numOfOnes: Int = Int(0)
    var numOfTwos: Int = Int(0)
    var numOfThrees: Int = Int(0)
    var numOfFours: Int = Int(0)
    var numOfFives: Int = Int(0)
    var numnOfSixes: Int = Int(0)
    var pairs: Int = Int(0)
    
    var pointsAvailable: Int = Int(0)
    
    // MARK: ********** didMove Section **********
    
    override func didMove(to view: SKView) {
        currentPlayer = player1
        setupBackGround()
        setupGameTable()
        setupIconWindow()
        setupScoresWindow()
        displayGameTable()
        displayMainMenu()
        displaySettingsMenu()
    }
    
    func displayGameTable() {
        
        backGround.addChild(gameTable)
        gameTable.addChild(logo)
        logo.addChild(logo2)
    }
    
    func displayMainMenu() {
        mainMenu.texture = GameConstants.Textures.MainMenu
        mainMenu.name = "MainMenu"
        mainMenu.position = CGPoint(x: 0, y: 0)
        mainMenu.size = CGSize(width: frame.size.width / 2, height: frame.size.height / 1.5)
        mainMenu.zPosition = GameConstants.ZPositions.Menu
        if gameState == .NewGame {
            setupMainMenuIcons()
        }
    }
    
    func displaySettingsMenu() {
        settingsMenu.texture = GameConstants.Textures.SettingsMenu
        settingsMenu.name = "SettingsMenu"
        settingsMenu.position = CGPoint(x: 0, y: 0)
        settingsMenu.size = CGSize(width: frame.size.width / 2, height: frame.size.height / 1.5)
        settingsMenu.zPosition = GameConstants.ZPositions.Menu
        setupSettingsMenuIcons()
    }

    // MARK: ********** Touches Section **********

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            iconWindowTouchLocation = touch.location(in: iconWindow)
            gameTableTouchLocation = touch.location(in: gameTable)
            mainMenuTouchLocation = touch.location(in: mainMenu)
            settingsMenuTouchLocation = touch.location(in: settingsMenu)
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
                playerState = .Rolling
            case "KeepScore":
                keepScoreIconTouched()
            default:
                break
            }
        }
    }
    
    func wasDiceTouched() {
        for die in currentDiceArray where die.rollable == true {
            currentDie = die
            if die.contains(gameTableTouchLocation) {
                let dieTextureSelected = selectedTextures[die.faceValue - 1]
                die.texture = dieTextureSelected
                die.selectable = false
                die.selected = true
                die.physicsBody?.isDynamic = false
                die.rollable = false
            } else {
                let dieTexture = unSelectedTextures[die.faceValue - 1]
                die.texture = dieTexture
                die.selectable = true
                die.selected = false
                die.physicsBody?.isDynamic = true
                die.rollable = true
            }
            evaluateCurrentRoll()
        }
        var count = 0
        for die in currentDiceArray where die.rollable == true {
            count += 1
        }
        if count == 0 {
            playerState = .Farkle
        }
    }

    func newGameIconTouched() {
        if gameState == .InProgress {
            print("game in progress")
            //displayGameInProgressWarning()
        } else {
            showIconWindowIcons()
            //gameTable.addChild(currentScoreLabel)
            fadeScoreLabel(isComplete: handlerBlock)
            gameState = .NewGame
            //setupNewGame()
        }
    }
    
    func setupNewGame() {
        gameState = .InProgress
        playerState = .Idle
        getCurrentGameSettings()
        setupPlayers()
        setupDice()
        setupDieFaces()
        currentPlayer = playersArray.first
        currentPlayerID = 0
        currentPlayer.nameLabel.fontColor = GameConstants.Colors.PlayerNameLabelFont
        currentPlayer.scoreLabel.fontColor = GameConstants.Colors.PlayerScoreLabelFont
    }
    
    func getCurrentGameSettings() {
        currentGame = Game()
    }
    
    func resumeIconTouched() {
        if gameState == .NewGame {
            print("no game in progress")
            //displayNoGameInProgreeMessage()
        } else {
            print("continue icon touched")
            showIconWindowIcons()
        }
    }
    
    func settingsIconTouched() {
        if gameState == .InProgress {
            print("game in progress")
            //displaySettingsChangeWillCancelCurrentGameWarning()
        } else {
            print("settings icon touched")
            showSettingsMenu()
        }
    }
    
    func exitIconTouched() {
        if gameState == .InProgress {
            print("game in progress")
            //displayExitGameWarning()
        } else {
            print("game exited")
            //displayConfirmationMessage()
            exit(0)
        }
    }
    
    func infoIconTouched() {
        //displayInfoWindow()
        print("Info Icon was Touched")
    }
    
    func soundIconTouched() {
        print("sound icon touched")
    }
    
    func backIconTouched() {
        print("back icon touched")
        showMainMenu()
    }
    
    func pauseIconTouched() {
        if pauseIcon.isPaused != true {
            print("pause icon touched")
            showMainMenu()
        }
    }
    
    func keepScoreIconTouched() {
        print("keep score icon touched")
        currentPlayer.currentRollScore += currentScore
        currentPlayer.score += currentPlayer.currentRollScore
        currentPlayer.scoreLabel.text = String(currentPlayer.score)
        currentPlayer.currentRollScore = 0
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
        currentPlayer.firstRoll = true
        resetDice()
        repositionDice()
        currentScore = 0
        for die in currentDiceArray {
            die.physicsBody?.isDynamic = true
        }
    }
    
    func startNewRoll() {
        currentPlayer.currentRollScore = 0
        currentDiceArray = diceArray
        currentPlayer.firstRoll = true

        for die in currentDiceArray {
            die.countThisRoll = 0
            die.ID = 0
            die.rollable = true
            scoringCombo = false
        }
        repositionDice()
        for die in currentDiceArray {
            die.physicsBody?.isDynamic = true
        }
    }
    
    func startNewRound() {
        print("start new round")
        currentPlayer.nameLabel.fontColor = UIColor.lightGray
        currentPlayer.scoreLabel.fontColor = UIColor.lightGray
        currentPlayerID = 0
        for player in playersArray {
            player.currentRollScore = 0
            player.firstRoll = true
        }
        for die in currentDiceArray {
            die.physicsBody?.isDynamic = true
        }
        currentGame.numRounds += 1
        resetDice()
        repositionDice()

    }
    
    func showMainMenu() {
        hideSettingMenu()
        hideIconWindowIcons()
        addMainMenu()
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
        addSettingsMenu()
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
        addIconWindowIcons()
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
        showMessage(msg: "Farkle")
        nextPlayer()
    }
    
    func showMessage(msg: String) {
        print("player farkled")
    }
    
    // MARK: ********** State Machine **********
    
    var gameState = GameState.NewGame {
        willSet {
            switch newValue {
            case .NewGame:
                setupNewGame()
            case .InProgress:
                print("game in progress")
            case .NewRound:
                startNewRound()
            case .GameOver:
                exit(0)
            }
        }
    }
    
    var playerState = PlayerState.Idle {
        willSet {
            switch newValue {
            case .Idle:
                print("player state: \(playerState)")
            case .Rolling:
                currentPlayer.scoreLabel.text = intToString(int: currentPlayer.score)
                rollDice()
            case .Finished:
                print("Player has finished")
            //currentPlayer.finished = true
            case .FinalRoll:
                print("Player has one final roll")
            //currentPlayer.finalRoll = true
            case .Farkle:
                farkle()
            case .NewRoll:
                startNewRoll()
                
            }
        }
    }
    
    // MARK: ********** Updates Section **********
    
    override func update(_ currentTime: TimeInterval) {

    }
}
