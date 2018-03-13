//
//  Level.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/2/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import Foundation

class Level {

    fileprivate var blocks = Array2D<Block>(columns: C.Game.numberOfColumns, rows: C.Game.numberOfRows)

    func blockAt(column: Int, row: Int) -> Block? {
        assert(column >= 0 && column < C.Game.numberOfColumns)
        assert(row >= 0 && row < C.Game.numberOfRows)
        return blocks[column, row]
    }

    func addBlock(at column: Int, and row: Int, with shape: Shape, for type: BlockType) {
        assert(column >= 0 && column < C.Game.numberOfColumns)
        assert(row >= 0 && row < C.Game.numberOfRows)
        blocks[column, row]?.color = shape.color
        blocks[column, row]?.type = type
    }

    func getBackgroundBlocks() -> Set<Block> {
        var set = Set<Block>()
        for row in 0 ..< C.Game.numberOfRows {
            for column in 0 ..< C.Game.numberOfColumns {
                let block = Block(column: column, row: row)
                set.insert(block)
            }
        }
        return set
    }

    func getGamingBlocks() -> Set<Block> {
        var set = Set<Block>()
        for row in 0 ..< C.Game.numberOfRows {
            for column in 0 ..< C.Game.numberOfColumns {
                let block = Block(column: column, row: row, color: .clear, type: .empty)
                blocks[column, row] = block
                set.insert(block)
            }
        }
        return set
    }

    func removeHintBlocks() {
        for row in 0 ..< C.Game.numberOfRows {
            for column in 0 ..< C.Game.numberOfColumns {
                if let block = blocks[column, row], block.type == .hint {
                    block.type = .empty
                }
            }
        }
    }

    func getRandomShape(column: Int = 0, row: Int = 0) -> Shape {
        let randomValue = Int(arc4random_uniform(UInt32(C.Game.numberOfShapes)))
        switch randomValue {
        case 0:
            return SquareShape(column: column, row: row)
        case 1:
            return TwoLineShape(column: column, row: row)
        case 2:
            return ThreeLineShape(column: column, row: row)
        case 3:
            return FourLineShape(column: column, row: row)
        case 4:
            return FiveLineShape(column: column, row: row)
        case 5:
            return CubeShape(column: column, row: row)
        default:
            return DotShape(column: column, row: row)
        }
    }
}
