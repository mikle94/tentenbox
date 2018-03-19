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
    var orientation: ShapeOrientation

    var hBlocksCount: Int { return 1 } // number of blocks horizontally
    var vBlocksCount: Int { return 1 } // number of blocks vertically

    var blockRowColumnPosition: [ShapeOrientation: [(columnDiff: Int, rowDiff: Int)]] { return [:] }

    var hashValue: Int {
        return blocks.reduce(0) { $0.hashValue ^ $1.hashValue }
    }

    init(column: Int, row: Int, orientation: ShapeOrientation = .random()) {
        self.column = column
        self.row = row
        self.orientation = orientation
        initializeBlocks()
    }

    final func initializeBlocks() {
        blocks = blockRowColumnPosition[orientation]!.map { (diff) -> Block in
            return Block(column: column + diff.columnDiff, row: row + diff.rowDiff, color: self.color, type: .real)
        }
    }
}

func == (lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}

enum ShapeOrientation: Int {
    case zero = 0, ninety

    static let count: Int = {
        var max: Int = 0
        while let _ = ShapeOrientation(rawValue: max) { max += 1 }
        return max
    }()

    static func random() -> ShapeOrientation {
        let randomValue = Int(arc4random_uniform(UInt32(count)))
        switch randomValue {
        case 0:
            return .zero
        default:
            return .ninety
        }
    }
}
