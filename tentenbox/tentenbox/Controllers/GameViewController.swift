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
        scene.addShapes(for: level.getBackgroundBlocks(), to: scene.blocksLayer)
        scene.addShapes(for: level.getGamingBlocks(), to: scene.gamingBlocksLayer)
    }

    private func createBottomFigures() {
        scene.createBottomFigures()
        scene.generateFigures()
    }

}
