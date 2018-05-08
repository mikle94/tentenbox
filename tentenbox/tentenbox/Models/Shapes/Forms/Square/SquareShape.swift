//
//  SquareShape.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/4/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit

class SquareShape: Shape {

    /*
     | 0 | 1 |
     | 2 | 3 |
    */

    override var color: SKColor {
        return Appearance.squareShapeColor
    }

    override var blockRowColumnPosition: [ShapeOrientation: [(columnDiff: Int, rowDiff: Int)]] {
        let differences: [(columnDiff: Int, rowDiff: Int)] = [(0, 0), (1, 0), (0, 1), (1, 1)]
        return [.zero: differences, .ninety: differences, .oneEighty: differences, .twoSeventy: differences]
    }

    override var hBlocksCount: Int {
        return 2
    }

    override var vBlocksCount: Int {
        return 2
    }
}
