//
//  CornerShape.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/19/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit

class CornerShape: Shape {

    /*
     | 0 | 1 |     | 0 | 1 |         | 0 |     | 0 |
     | 2 |             | 2 |     | 1 | 2 |     | 1 | 2 |
     */

    override var color: SKColor {
        return .brown
    }

    override var blockRowColumnPosition: [ShapeOrientation: [(columnDiff: Int, rowDiff: Int)]] {
        return [
            .zero: [(0, 0), (1, 0), (0, 1)],
            .ninety: [(0, 0), (1, 0), (1, 1)],
            .oneEighty: [(1, 0), (0, 1), (1, 1)],
            .twoSeventy: [(0, 0), (0, 1), (1, 1)]
        ]
    }

    override var hBlocksCount: Int {
        return 2
    }

    override var vBlocksCount: Int {
        return 2
    }
}
