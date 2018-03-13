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
    // layer for background blocks
    let blocksLayer: SKShapeNode = {
        let size = U.screen.width - C.Appearance.margin * 2
        let node = SKShapeNode(rect: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        node.position = blocksLayerPosition
        node.lineWidth = 0
        return node
    }()
    // layer for gaming blocks
    let gamingBlocksLayer: SKShapeNode = {
        let size = U.screen.width - C.Appearance.margin * 2
        let node = SKShapeNode(rect: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        node.position = blocksLayerPosition
        node.lineWidth = 0
        return node
    }()
    static let blocksLayerPosition = CGPoint(
        x: C.Appearance.margin,
        y: U.screen.height - U.statusBarHeight - C.Appearance.margin - (C.Game.blockSize + C.Appearance.itemMargin) * CGFloat(C.Game.numberOfRows)
    )

    // bottom figure containers
    var figureContainers: [SKShapeNode] = []
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
        gameLayer.addChild(blocksLayer)
        gameLayer.addChild(gamingBlocksLayer)
    }

    // MARK: Implementation

    func addShapes(for blocks: Set<Block>, to layer: SKShapeNode) {
        let size = CGSize(width: C.Game.blockSize, height: C.Game.blockSize)
        for block in blocks {
            let backgroundTexture = SKTexture(image: #imageLiteral(resourceName: "block"))
            let node = SKSpriteNode(texture: backgroundTexture, size: size)
            node.color = block.nodeColor
            node.colorBlendFactor = 1
            node.size = size
            node.position = Calculation.pointFor(column: block.column, row: block.row, size: size)
            layer.addChild(node)
            block.node = node
        }
    }

    func createBottomFigures() {
        for i in 0 ..< 3 {
            guard let figurePosition = BottomFigure(rawValue: i) else { continue }
            let nodeContainer = SKShapeNode(rect: Calculation.containerRect(for: figurePosition))
            nodeContainer.lineWidth = 0
            nodeContainer.position = Calculation.containerPosition(for: figurePosition)
            nodeContainer.name = C.Name.bottomFigureContainer
            figureContainers.append(nodeContainer)
            gameLayer.addChild(nodeContainer)
        }
    }

    func generateFigures() {
        guard let level = level else {
            fatalError("Level class is not initialized")
        }
        for (index, container) in figureContainers.enumerated() where container.children.isEmpty {
            let shape = level.getRandomShape()
            guard let figurePosition = BottomFigure(rawValue: index) else { continue }
            let shapeRect = Calculation.rect(for: shape)
            let figure = initPossibleFigure(with: shape, rect: shapeRect, for: figurePosition)
            figure.userData = ["shape": shape]
            figureContainers[index].addChild(figure)
            let originalPosition = Calculation.position(for: figurePosition, frame: shapeRect)
            let moveAction = SKAction.move(to: originalPosition, duration: C.Appearance.figureAnimationDuration)
            figure.run(moveAction)
        }
    }

    private func initPossibleFigure(with shape: Shape, rect: CGRect, for figurePosition: BottomFigure) -> SKShapeNode {
        let figure = SKShapeNode(rect: rect)
        configureFigure(figure, with: shape, rect: rect, for: figurePosition)
        return figure
    }

    private func configureFigure(_ figure: SKShapeNode?, with shape: Shape, rect: CGRect, for type: BottomFigure) {
        guard let figure = figure else { return }
        figure.name = C.Name.bottomFigure
        figure.position = Calculation.position(for: type, frame: rect, adjusted: true)
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
            node.position = Calculation.pointFor(column: block.column, row: block.row, size: size)
            figure.addChild(node)
            block.node = node
        }
    }

    // MARK: Touches

    enum TouchAction {
        case moved, ended
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        guard let (node, location) = determineNodeAndPoint(for: touch) else { return }
        scaleAndMove(node, at: location)
    }

    private func determineNodeAndPoint(for touch: UITouch) -> (SKNode, CGPoint)? {
        let touchLocation = touch.location(in: self)
        let node = atPoint(touchLocation)
        guard let nodeName = node.name else { return nil }
        switch nodeName {
        // small block
        case C.Name.bottomFigureBlock:
            guard let parentNode = node.parent, let parentContainer = parentNode.parent else { return nil }
            let location = touch.location(in: parentContainer)
            return (parentNode, location)
        // whole shape figure
        case C.Name.bottomFigure:
            guard let parentContainer = node.parent else { return nil }
            let location = touch.location(in: parentContainer)
            return (node, location)
        // shape figure touch container area
        case C.Name.bottomFigureContainer:
            guard let childNode = node.children.first else { return nil }
            let location = touch.location(in: node)
            return (childNode, location)
        default:
            return nil
        }
    }

    private func scaleAndMove(_ node: SKNode, at point: CGPoint? = nil, toInitialState: Bool = false) {
        if !toInitialState { touchedFigure = node }
        let scaleValue: CGFloat = C.Game.touchedBlockSize / C.Game.figureBlockSize
        let scaleAction = SKAction.scale(to: toInitialState ? 1 : scaleValue, duration: toInitialState ? C.Appearance.figureAnimationDuration : 0)
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
        let moveAction = SKAction.move(to: nodePosition, duration: toInitialState ? C.Appearance.figureAnimationDuration : 0)
        let group = SKAction.group([scaleAction, moveAction])
        node.removeAllActions()
        node.run(group)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches, with: .moved)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches, with: .ended)
    }

    private func handleTouches(_ touches: Set<UITouch>, with action: TouchAction) {
        guard let touch = touches.first, let node = touchedFigure, let parentNode = node.parent else { return }
        // detect touch location and node position
        let touchLocation = touch.location(in: parentNode)
        let nodePosition = CGPoint(
            x: touchLocation.x - node.frame.width / 2,
            y: touchLocation.y + C.Appearance.figureTouchOffset
        )
        // move touched figure above user finger
        if action == .moved {
            let moveAction = SKAction.move(to: nodePosition, duration: 0)
            node.run(moveAction)
        }
        guard let shape = node.userData?["shape"] as? Shape else { return }
        // determine position on gaming grip
        let position = parentNode.convert(nodePosition, to: blocksLayer)
        // if we found starting block for figure and hit is available there
        guard let (column, row) = findBlock(at: position, with: shape), figureHintAvailable(for: column, and: row, with: shape) else {
            // if not, move back
            if action == .moved {
                level?.removeHintBlocks()
                reloadBlocksLayer()
            } else if action == .ended {
                deleteAndSetBack()
            }
            return
        }
        // display figure hint or put it on the grid
        if action == .moved {
            displayFigure(at: column, and: row, with: shape, for: .hint)
        } else if action == .ended {
            node.removeFromParent()
            touchedFigure = nil
            displayFigure(at: column, and: row, with: shape, for: .real)
            generateFigures()
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        deleteAndSetBack()
    }

    private func findBlock(at position: CGPoint, with shape: Shape) -> (Int, Int)? {
        let hBlocksCount = shape.hBlocksCount
        let vBlocksCount = shape.vBlocksCount
        let hBlockSize = C.Game.touchedBlockSize * CGFloat(hBlocksCount) + C.Appearance.itemMargin * CGFloat(hBlocksCount - 1)
        let vBlockSize = C.Game.touchedBlockSize * CGFloat(vBlocksCount) + C.Appearance.itemMargin * CGFloat(vBlocksCount - 1)
        let partOfBlock = C.Game.touchedBlockSize * 0.5 // 50% to highlight
        // checking if gaming grip contains touch position with some adjustments (50% of block needed)
        let biggerThanLeftSide = position.x > -partOfBlock
        let biggerThanBottomSide = position.y > -partOfBlock
        let lowerThanRightSide = position.x + hBlockSize < blocksLayer.frame.width - partOfBlock + C.Game.touchedBlockSize
        let lowerThanTopSide = position.y + vBlockSize < blocksLayer.frame.height - partOfBlock + C.Game.touchedBlockSize
        guard biggerThanLeftSide && biggerThanBottomSide && lowerThanTopSide && lowerThanRightSide else { return nil }
        // afjusting offsets if needed
        let xOffset = position.x + (position.x > blocksLayer.frame.width - hBlockSize ? 0 : partOfBlock)
        let yOffset = position.y + (position.y > blocksLayer.frame.height - vBlockSize ? 0 : partOfBlock)
        // getting column and row
        let column = Int(xOffset / (blocksLayer.frame.width / CGFloat(C.Game.numberOfColumns)))
        let row = Int(yOffset / (blocksLayer.frame.height / CGFloat(C.Game.numberOfRows)))
        guard column >= 0 && column < C.Game.numberOfColumns, row >= 0 && row < C.Game.numberOfRows else { return nil }
        return (column, row)
    }

    private func figureHintAvailable(for column: Int, and row: Int, with shape: Shape) -> Bool {
        guard let level = level else { return false }
        var hintAvailable: Bool = true
        for difference in shape.blockRowColumnPosition {
            let hintColumn = column + difference.columnDiff
            let hintRow = row + difference.rowDiff
            guard let block = level.blockAt(column: hintColumn, row: hintRow), !block.isHintAvailable else { continue }
            hintAvailable = false
            break
        }
        return hintAvailable
    }

    private func displayFigure(at column: Int, and row: Int, with shape: Shape, for type: BlockType) {
        guard let level = level else { return }
        level.removeHintBlocks()
        for difference in shape.blockRowColumnPosition {
            let hintColumn = column + difference.columnDiff
            let hintRow = row + difference.rowDiff
            level.addBlock(at: hintColumn, and: hintRow, with: shape, for: type)
        }
        reloadBlocksLayer()
    }

    private func reloadBlocksLayer() {
        for row in 0 ..< C.Game.numberOfRows {
            for column in 0 ..< C.Game.numberOfColumns {
                guard let block = level?.blockAt(column: column, row: row) else { return }
                block.node?.color = block.nodeColor
            }
        }
    }

    private func deleteAndSetBack() {
        guard let figure = touchedFigure else { return }
        touchedFigure = nil
        scaleAndMove(figure, toInitialState: true)
        level?.removeHintBlocks()
        reloadBlocksLayer()
    }
}
