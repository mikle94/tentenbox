//
//  Shape.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/4/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import Foundation
import SpriteKit

class Shape: Hashable {

    var color: SKColor { return .clear }
    var blocks = [Block]()
    var column, row: Int

    var hBlocksCount: Int { return 1 } // number of blocks horizontally
    var vBlocksCount: Int { return 1 } // number of blocks vertically

    var blockRowColumnPosition: [(columnDiff: Int, rowDiff: Int)] { return [] }

    var hashValue: Int {
        return blocks.reduce(0) { $0.hashValue ^ $1.hashValue }
    }

    init(column: Int, row: Int) {
        self.column = column
        self.row = row
        initializeBlocks()
    }

    final func initializeBlocks() {
        blocks = blockRowColumnPosition.map { (diff) -> Block in
            return Block(column: column + diff.columnDiff, row: row + diff.rowDiff)
        }
    }
}

func == (lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
