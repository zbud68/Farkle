//
//  GameTable_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
        
    func setupGameTable(isComplete: (Bool) -> Void) {
        
        gameTable = SKSpriteNode(imageNamed: "WindowPopup")
        gameTable.name = "Game Table"
        gameTable.zPosition = GameConstants.ZPositions.GameTable
        gameTable.size = CGSize(width: backGround.size.width - 75, height: backGround.size.height + 20)
        gameTable.position = CGPoint(x: (backGround.frame.maxX - (gameTable.size.width / 2) + 40), y: 0)
        gameTable.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: gameTable.frame.minX - 15, y: gameTable.frame.minY + 40), size: CGSize(width: gameTable.size.width - 140, height: gameTable.size.height - 80)))
        gameTable.physicsBody?.affectedByGravity = false
        gameTable.physicsBody?.allowsRotation = false
        gameTable.physicsBody?.isDynamic = true
        gameTable.physicsBody?.restitution = 0.75

        gameTable.physicsBody?.categoryBitMask = 1
        gameTable.physicsBody?.collisionBitMask = 1
        gameTable.physicsBody?.contactTestBitMask = 1
        gameTable.zRotation = 0

        setupLogo(isComplete: handlerBlock)
        setupCurrentScoreLabel(isComplete: handlerBlock)
        isComplete(true)
    }
    
    func setupLogo(isComplete: (Bool) -> Void) {
        
        logo.fontName = GameConstants.StringConstants.FontName
        logo.fontColor = GameConstants.Colors.LogoFont
        logo.fontSize = GameConstants.Sizes.Logo1Font
        logo.alpha = 0.65
        logo.position = CGPoint(x: 0, y: -50)
        logo.zPosition = GameConstants.ZPositions.Logo
        logo.zRotation = 0
        
        logo2.fontName = GameConstants.StringConstants.FontName
        logo2.fontColor = GameConstants.Colors.LogoFont
        logo2.fontSize = GameConstants.Sizes.Logo2Font
        logo2.alpha = 0.65
        logo2.zRotation = 75
        
        logo2.zPosition = GameConstants.ZPositions.Logo
        logo2.position = CGPoint(x: -185, y: -25)
        logo2.zRotation = 0
        isComplete(true)
    }
    
    func setupCurrentScoreLabel(isComplete: (Bool) -> Void) {
        
        currentScoreLabel.name = "CurrentScoreLabel"
        currentScoreLabel.zPosition = gameTable.zPosition + 0.5
        //currentScoreLabel.text = "\(currentPlayer.name) score this roll: \(currentPlayer.currentRollScore)"
        currentScoreLabel.fontName = GameConstants.StringConstants.FontName
        currentScoreLabel.fontColor = GameConstants.Colors.LogoFont
        currentScoreLabel.fontSize = 24
        currentScoreLabel.alpha = 1
        currentScoreLabel.zRotation = 0
        currentScoreLabel.position = CGPoint(x: 0, y: gameTable.frame.maxY - (gameTable.size.height / 4))
        isComplete(true)
    }
    
    func fadeScoreLabel(isComplete: (Bool) -> Void) {
        //GameTable.addChild(currentScoreLabel)
        let wait = SKAction.wait(forDuration: 0.5)
        let fadeToAlpha = SKAction.fadeAlpha(to: 0.65, duration: 0.75)
        let labelSeq = SKAction.sequence([wait, fadeToAlpha])

        currentScoreLabel.run(labelSeq)

        isComplete(true)
    }
    
}
