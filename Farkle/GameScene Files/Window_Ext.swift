//
//  Window_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupIconWindow(isComplete: (Bool) -> Void) {
        iconWindow = SKSpriteNode(texture: SKTexture(imageNamed: "WindowPopup1"))
        iconWindow.size = CGSize(width: 165, height: (backGround.size.height / 4))
        iconWindow.position = CGPoint(x: ((backGround.frame.minX) + (iconWindow.size.width / 2)) + 5, y: ((backGround.frame.maxY) - (iconWindow.size.height / 2)) - 10)
        iconWindow.zPosition = GameConstants.ZPositions.Window
        iconWindow.name = "Icon Window"
        iconWindow.zRotation = 0

        backGround.addChild(iconWindow)
        setupIconWindowIcons(isComplete: handlerBlock)
        isComplete(true)
    }

    func setupScoresWindow(isComplete: (Bool) -> Void) {
        scoresWindow = SKSpriteNode(texture: SKTexture(imageNamed: "WindowPopup2"))
        scoresWindow.size = CGSize(width: 165, height: (backGround.size.height / 4) * 3)
        scoresWindow.position = CGPoint(x: iconWindow.position.x, y: (iconWindow.position.y - (iconWindow.size.height * 2) + 10))
        scoresWindow.zPosition = GameConstants.ZPositions.Window
        scoresWindow.name = "Player Scores Window"
        scoresWindow.zRotation = 0

        backGround.addChild(scoresWindow)
        isComplete(true)
    }
}
