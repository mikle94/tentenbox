//
//  GameScene.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/2/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    // MARK: Properties

    var level: Level?

    let gameLayer = SKNode()
    let blocksLayer = SKNode()

    // MARK: Initialization

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }

    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = C.Appearance.sceneBackgroundColor

        addChild(gameLayer)
        let layerPosition = CGPoint(
            x: -(C.Game.blockWidth + C.Appearance.itemMargin) * CGFloat(C.Game.numberOfColumns) / 2,
            y: -(C.Game.blockHeight + C.Appearance.itemMargin) * CGFloat(C.Game.numberOfRows) / 2
        )
        blocksLayer.position = layerPosition
        gameLayer.addChild(blocksLayer)
    }

    // MARK: Implementation

    func addShapes(for blocks: Set<Block>) {
        for block in blocks {
            let node = SKShapeNode(rectOf: CGSize(width: C.Game.blockWidth, height: C.Game.blockHeight), cornerRadius: C.Appearance.radius)
            node.position = pointFor(column: block.column, row: block.row)
            node.fillColor = block.color
            node.lineWidth = 0
            blocksLayer.addChild(node)
            block.node = node
        }
    }

    func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: C.Game.blockWidth * CGFloat(column) + C.Appearance.itemMargin * CGFloat(column) + C.Game.blockWidth / 2,
            y: C.Game.blockHeight * CGFloat(row) + C.Appearance.itemMargin * CGFloat(row) + C.Game.blockHeight / 2
        )
    }

    // MARK: Touches

    override func didMove(to view: SKView) {
    }

    func touchDown(atPoint pos: CGPoint) {
    }

    func touchMoved(toPoint pos: CGPoint) {
    }

    func touchUp(atPoint pos: CGPoint) {
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
