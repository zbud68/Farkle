//
//  GameTable_Ext.swift
//  Farkle
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
        
    func setupGameTable() {
        gameTable = SKSpriteNode(imageNamed: "WindowPopup")
        gameTable.name = "Game Table"
        gameTable.zPosition = GameConstants.ZPositions.GameTable
        gameTable.size = CGSize(width: backGround.size.width - 75, height: backGround.size.height + 20)
        gameTable.position = CGPoint(x: (backGroundMaxX - (gameTable.size.width / 2) + 40), y: 0)
        gameTable.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: gameTable.frame.minX - 15, y: gameTable.frame.minY + 40), size: CGSize(width: gameTable.size.width - 140, height: gameTable.size.height - 80)))
        gameTable.physicsBody?.affectedByGravity = false
        gameTable.physicsBody?.allowsRotation = false
        gameTable.physicsBody?.isDynamic = true
        gameTable.physicsBody?.restitution = 0.75

        gameTable.physicsBody?.categoryBitMask = 1
        gameTable.physicsBody?.collisionBitMask = 1
        gameTable.physicsBody?.contactTestBitMask = 1

        gameTableMaxX = gameTable.frame.maxX
        gameTableMaxY = gameTable.frame.maxY
        gameTableMinX = gameTable.frame.minX
        gameTableMinY = gameTable.frame.minY
        gameTableWidth = gameTable.size.width
        gameTableHeight = gameTable.size.height

        backGround.addChild(gameTable)
    }
    
    func setupLabel() {
        
        logo.fontName = GameConstants.Label.FontName
        logo.fontColor = GameConstants.Label.FontColor
        logo.fontSize = 144
        logo.alpha = 0.4
        logo.position = CGPoint(x: -25, y: -50)
        logo.zPosition = GameConstants.ZPositions.Logo
        
        logo2.fontName = GameConstants.Label.FontName
        logo2.fontColor = GameConstants.Label.FontColor
        logo2.fontSize = 36
        logo2.alpha = 0.4
        logo2.zRotation = 75
        logo2.zPosition = GameConstants.ZPositions.Logo
        logo2.position = CGPoint(x: -210, y: -75)
        gameTable.addChild(logo)
        logo.addChild(logo2)
    }
}
