//
//  Icon_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupIconWindowIcons(isComplete: (Bool) -> Void) {
        pauseIcon.texture = SKTexture(imageNamed: "GreenPause")
        pauseIcon.name = "Pause"
        pauseIcon.size = CGSize(width: 32, height: 32)
        pauseIcon.zPosition = GameConstants.ZPositions.Icon
        
        pauseIcon.position = CGPoint(x: (pauseIcon.size.width / 2) - (iconWindow.size.width / 3) + 3, y: iconWindow.size.height / 3 - pauseIcon.size.height)
        
        rollDiceIcon.texture = SKTexture(imageNamed: "IconRed")
        rollDiceIcon.position = CGPoint(x: pauseIcon.position.x + 60, y: iconWindow.size.height / 5 - rollDiceIcon.size.height)
        rollDiceIcon.name = "RollDice"
        rollDiceIcon.size = CGSize(width: 60, height: 40)
        rollDiceIcon.zPosition = GameConstants.ZPositions.Dice
        
        keepScoreIcon.texture = SKTexture(imageNamed: "IconGreen")
        keepScoreIcon.position = CGPoint(x: rollDiceIcon.position.x, y: rollDiceIcon.position.y - 40)
        keepScoreIcon.name = "KeepScore"
        keepScoreIcon.size = CGSize(width: 60, height: 40)
        keepScoreIcon.zPosition = GameConstants.ZPositions.Dice
        
        setupIconWindowIconsArray(isComplete: handlerBlock)
        isComplete(true)
    }

    func setupMainMenuIconsArray(isComplete: (Bool) -> Void) {
        mainMenuIconsArray = [newGameIcon, resumeIcon, settingsIcon, exitIcon, infoIcon]
        isComplete(true)
    }
    
    func setupSettingsMenuIconsArray(isComplete: (Bool) -> Void) {
        settingsMenuIconsArray = [soundIcon, backIcon]
        isComplete(true)
    }
    
    func setupIconWindowIconsArray(isComplete: (Bool) -> Void) {
        iconWindowIconsArray = [pauseIcon, rollDiceIcon, keepScoreIcon]
        isComplete(true)
    }
    
    func addIconWindowIcons(isComplete: (Bool) -> Void) {
        iconWindow.addChild(pauseIcon)
        iconWindow.addChild(rollDiceIcon)
        iconWindow.addChild(keepScoreIcon)
        isComplete(true)
    }
}
