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

    // whole layer
    let gameLayer = SKNode()
    // layer for gaming blocks
    let blocksLayer = SKNode()

    static let blocksLayerPosition = CGPoint(
        x: C.Appearance.margin,
        y: U.screen.height - U.statusBarHeight - C.Appearance.margin - (C.Game.blockSize + C.Appearance.itemMargin) * CGFloat(C.Game.numberOfRows)
    )

    // bottom figure containers
    var figureContainers: [SKShapeNode] = []
    var figures: [SKShapeNode?] = [SKShapeNode?](repeatElement(nil, count: 3))
    // fogure being touched by user
    var touchedFigure: SKNode?

    // MARK: Initialization

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }

    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.0, y: 0.0)
        backgroundColor = C.Appearance.sceneBackgroundColor

        addChild(gameLayer)
        blocksLayer.position = GameScene.blocksLayerPosition
        gameLayer.addChild(blocksLayer)

        p(blocksLayer.frame)
        p(blocksLayer.position)
    }

    // MARK: Calculation Functions

    private func pointFor(column: Int, row: Int, size: CGSize) -> CGPoint {
        return CGPoint(
            x: size.width * CGFloat(column) + C.Appearance.itemMargin * CGFloat(column) + size.width / 2,
            y: size.height * CGFloat(row) + C.Appearance.itemMargin * CGFloat(row) + size.height / 2
        )
    }

    // calculate rect for figure's shape
    private func rect(for shape: Shape) -> CGRect {
        let width = CGFloat(shape.hBlocksCount) * C.Game.figureBlockSize + CGFloat(shape.hBlocksCount - 1) * C.Appearance.itemMargin
        let height = CGFloat(shape.vBlocksCount) * C.Game.figureBlockSize + CGFloat(shape.vBlocksCount - 1) * C.Appearance.itemMargin
        return CGRect(x: 0.0, y: 0.0, width: width, height: height)
    }

    // calculate position for figure
    private func position(for figure: BottomFigure, frame: CGRect) -> CGPoint {
        let rect = containerRect(for: figure)
        return CGPoint(
            x: rect.width / 2 - frame.width / 2,
            y: rect.width / 2 - frame.height / 2
        )
    }

    // calculate rect for figure container
    private func containerRect(for: BottomFigure) -> CGRect {
        let width = (U.screen.width - C.Appearance.margin * 4) / 3
        return CGRect(origin: .zero, size: CGSize(width: width, height: width))
    }

    // calculate position for figure container
    private func containerPosition(for figure: BottomFigure) -> CGPoint {
        let width = (U.screen.width - C.Appearance.margin * 4) / 3
        return CGPoint(
            x: C.Appearance.margin * CGFloat(figure.rawValue + 1) + width * CGFloat(figure.rawValue),
            y: GameScene.blocksLayerPosition.y - width - C.Appearance.margin * 2
        )
    }

    // MARK: Implementation

    func addShapes(for blocks: Set<Block>) {
        let size = CGSize(width: C.Game.blockSize, height: C.Game.blockSize)
        for block in blocks {
            let backgroundTexture = SKTexture(image: #imageLiteral(resourceName: "block"))
            let node = SKSpriteNode(texture: backgroundTexture, size: size)
            node.color = block.color
            node.colorBlendFactor = 1
            node.size = size
            node.position = pointFor(column: block.column, row: block.row, size: size)
            blocksLayer.addChild(node)
            block.node = node
        }
    }

    func createBottomFigures() {
        for i in 0 ..< 3 {
            guard let figurePosition = BottomFigure(rawValue: i) else { continue }
            let nodeContainer = SKShapeNode(rect: containerRect(for: figurePosition))
            nodeContainer.lineWidth = 0
            nodeContainer.position = containerPosition(for: figurePosition)
            nodeContainer.name = C.Name.bottomFigureContainer
            figureContainers.append(nodeContainer)
            gameLayer.addChild(nodeContainer)
        }
    }

    func generateFigures() {
        guard let level = level else {
            fatalError("Level class is not initialized")
        }
        for i in 0 ..< figureContainers.count {
            let shape = level.getRandomShape()
            guard let figurePosition = BottomFigure(rawValue: i) else { continue }
            let figure = figures[i] ?? initPossibleFigure(with: shape, for: figurePosition)
            figures[i] = figure
            figureContainers[i].addChild(figure)
        }
    }

    private func initPossibleFigure(with shape: Shape, for figurePosition: BottomFigure) -> SKShapeNode {
        let shapeRect = rect(for: shape)
        let node = SKShapeNode(rect: shapeRect)
        configureFigure(node, with: shape, rect: shapeRect, for: figurePosition)
        return node
    }

    private func configureFigure(_ figure: SKShapeNode?, with shape: Shape, rect: CGRect, for type: BottomFigure) {
        guard let figure = figure else { return }
        figure.name = C.Name.bottomFigure
        figure.position = position(for: type, frame: rect)
        figure.fillColor = .clear
        figure.strokeColor = .clear
        add(shape, to: figure)
    }

    func add(_ shape: Shape, to figure: SKShapeNode) {
        let size = CGSize(width: C.Game.figureBlockSize, height: C.Game.figureBlockSize)
        for block in shape.blocks {
            let backgroundTexture = SKTexture(image: #imageLiteral(resourceName: "block"))
            let node = SKSpriteNode(texture: backgroundTexture, size: size)
            node.color = shape.color
            node.colorBlendFactor = 1
            node.name = C.Name.bottomFigureBlock
            node.position = pointFor(column: block.column, row: block.row, size: size)
            figure.addChild(node)
            block.node = node
        }
    }

    // MARK: Touches

    override func didMove(to view: SKView) {
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let node = atPoint(touchLocation)
        if let nodeName = node.name {
            switch nodeName {
            // small block
            case C.Name.bottomFigureBlock:
                guard let parentNode = node.parent, let parentContainer = parentNode.parent else { return }
                let location = touch.location(in: parentContainer)
                scaleAndMove(parentNode, at: location)
            // whole shape figure
            case C.Name.bottomFigure:
                if let parentContainer = node.parent {
                    let location = touch.location(in: parentContainer)
                    scaleAndMove(node, at: location)
                } else {
                    scaleAndMove(node)
                }
            // shape figure touch container area
            case C.Name.bottomFigureContainer:
                guard let childNode = node.children.first else { return }
                let location = touch.location(in: node)
                scaleAndMove(childNode, at: location)
            default:
                break
            }
        }
    }

    private func scaleAndMove(_ node: SKNode, at point: CGPoint? = nil, toInitialState: Bool = false) {
        if !toInitialState { touchedFigure = node }
        let scaleValue: CGFloat = C.Game.touchedBlockSize / C.Game.figureBlockSize
        let scaleAction = SKAction.scale(to: toInitialState ? 1 : scaleValue, duration: toInitialState ? 0.125 : 0)
        let nodePosition: CGPoint
        if toInitialState, let parent = node.parent {
            nodePosition = CGPoint(
                x: parent.frame.width / 2 - node.frame.width / 2 * (1 / scaleValue),
                y: parent.frame.height / 2 - node.frame.height / 2 * (1 / scaleValue)
            )
        } else {
            nodePosition = CGPoint(
                x: (point?.x ?? 0) - node.frame.width / 2 * scaleValue,
                y: (point?.y ?? 0) + C.Appearance.figureTouchOffset
            )
        }
        let moveAction = SKAction.move(to: nodePosition, duration: toInitialState ? 0.125 : 0)
        let group = SKAction.group([scaleAction, moveAction])
        node.removeAllActions()
        node.run(group)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let node = touchedFigure, let parentNode = node.parent else { return }
        let touchLocation = touch.location(in: parentNode)
        let nodePosition = CGPoint(
            x: touchLocation.x - node.frame.width / 2,
            y: touchLocation.y + C.Appearance.figureTouchOffset
        )
        let moveAction = SKAction.move(to: nodePosition, duration: 0)
        node.run(moveAction)
//        let position = parentNode.convert(nodePosition, to: blocksLayer)
//        p(position)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        deleteAndSetBack()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        deleteAndSetBack()
    }

    private func deleteAndSetBack() {
        guard let figure = touchedFigure else { return }
        touchedFigure = nil
        scaleAndMove(figure, toInitialState: true)
    }
}
