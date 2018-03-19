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

    lazy var scene: GameScene = {
        let scene = GameScene(size: self.skView?.bounds.size ?? U.screen.size)
        scene.scaleMode = .aspectFill
        scene.level = level
        return scene
    }()

    lazy var level = Level()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        skView?.presentScene(scene)
        beginGame()
    }

    // MARK: Implementation

    func beginGame() {
        createGrid()
        createBottomFigures()
    }

    private func createGrid() {
        let (backgroundBlocks, gamingBlocks) = level.getStartingBlocks()
        scene.addShapes(for: backgroundBlocks, to: scene.blocksLayer, with: C.Game.blockSize)
        scene.addShapes(for: gamingBlocks, to: scene.gamingBlocksLayer, with: C.Game.blockSize)
    }

    private func createBottomFigures() {
        scene.createBottomFigures()
        scene.generateFigures()
    }

}
