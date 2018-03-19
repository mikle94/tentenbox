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

extension Shape {

    static func random(column: Int = 0, row: Int = 0) -> Shape {
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

func == (lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
