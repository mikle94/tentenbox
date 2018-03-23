//
//  GameViewController.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/2/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    // MARK: Properties

    lazy var skView: SKView? = {
        let skView = self.view as? SKView
        skView?.isMultipleTouchEnabled = false
        skView?.showsNodeCount = true
        skView?.showsFPS = true
        return skView
    }()

    lazy var menuScene: MenuScene = {
        let scene = MenuScene(size: self.skView?.bounds.size ?? U.screen.size)
        scene.scaleMode = .aspectFill
        scene.sceneDelegate = self
        return scene
    }()

    lazy var gameScene: GameScene = {
        let scene = GameScene(size: self.skView?.bounds.size ?? U.screen.size)
        scene.scaleMode = .aspectFill
        scene.level = level
        return scene
    }()

    lazy var level = Level()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        skView?.presentScene(menuScene)
    }

    // MARK: Implementation

    func beginGame() {
        createGrid()
        createBottomFigures()
    }

    private func createGrid() {
        let (backgroundBlocks, gamingBlocks) = level.getStartingBlocks()
        gameScene.addShapes(for: backgroundBlocks, to: gameScene.blocksLayer, with: C.Game.blockSize)
        gameScene.addShapes(for: gamingBlocks, to: gameScene.gamingBlocksLayer, with: C.Game.blockSize)
    }

    private func createBottomFigures() {
        gameScene.createBottomFigures()
        gameScene.generateFigures()
    }

}

// MARK: MenuSceneDelegate implementation

extension GameViewController: MenuSceneDelegate {

    func playGamePressed() {
        let transition: SKTransition = .crossFade(withDuration: 0.5)
        skView?.presentScene(gameScene, transition: transition)
        beginGame()
    }

}
