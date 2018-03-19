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

    func getStartingBlocks() -> (background: [Block], gaming: [Block]) {
        let backgroundBlocks = generateBlocks(with: .background)
        let gamingBlocks = generateBlocks(with: .empty)
        return (backgroundBlocks, gamingBlocks)
    }

    private func generateBlocks(with type: BlockType) -> [Block] {
        var blocks = [Block]()
        for row in 0 ..< C.Game.numberOfRows {
            for column in 0 ..< C.Game.numberOfColumns {
                let block = Block(column: column, row: row, type: type)
                if type == .empty {
                    self.blocks[column, row] = block
                }
                blocks.append(block)
            }
        }
        return blocks
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

    private enum LineOrientation {
        case horizontal, vertical
    }

    func getFilledLines() -> [[Block]]? {
        var lines: [[Block]] = []
        lines += getFilledLines(for: .horizontal)
        lines += getFilledLines(for: .vertical)
        return lines.isEmpty ? nil : lines
    }

    private func getFilledLines(for orientation: LineOrientation) -> [[Block]] {
        var lines: [[Block]] = []
        for i in 0 ..< C.Game.numberOfRows {//stride(from: C.Game.numberOfRows - 1, to: 0, by: -1) {
            var lineFilled = true
            var lineBlocks: [Block] = []
            for j in 0 ..< C.Game.numberOfColumns {
                let column = orientation == .horizontal ? j : i
                let row = orientation == .horizontal ? i : j
                guard let block = blocks[column, row], block.type == .real else {
                    lineFilled = false
                    break
                }
                lineBlocks.append(block)
            }
            if lineFilled {
                lines.append(lineBlocks)
            }
        }
        return lines
    }

    func highlightLine(_ blocks: [Block]) {
        _ = blocks.map { $0.type = .highlighted }
    }

    func removeLine(_ blocks: [Block]) {
        _ = blocks.map { $0.type = .empty }
    }

    func areMovesAvailable(_ shapes: [Shape]) -> Bool {
        var availableBlocks: [Block] = []
        for row in 0 ..< C.Game.numberOfRows {
            for column in 0 ..< C.Game.numberOfColumns {
                guard let block = blockAt(column: column, row: row), block.type == .empty else { continue }
                availableBlocks.append(block)
            }
        }
        for shape in shapes {
            for block in availableBlocks {
                var blockMatch: Bool = true
                for difference in shape.blockRowColumnPosition[shape.orientation]! {
                    let hintColumn = block.column + difference.columnDiff
                    let hintRow = block.row + difference.rowDiff
                    let blocks = availableBlocks.filter({ block -> Bool in
                        return hintColumn == block.column && hintRow == block.row
                    })
                    if blocks.isEmpty {
                        blockMatch = false
                        break
                    } else {
                        continue
                    }
                }
                if blockMatch { return true }
            }
        }
        return false
    }

    func removeBlocks() {
        for row in 0 ..< C.Game.numberOfRows {
            for column in 0 ..< C.Game.numberOfColumns {
                guard let block = blockAt(column: column, row: row) else { continue }
                block.type = .empty
            }
        }
    }

    func getRandomShape(column: Int = 0, row: Int = 0) -> Shape {
        return Shape.random(column: column, row: row)
    }
}
