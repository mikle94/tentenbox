//
//  LShape.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/19/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit

class LShape: Shape {

    /*
     | 0 | 1 | 2 |     | 0 | 1 | 2 |             | 0 |     | 0 |
     | 3 |                     | 3 |             | 1 |     | 1 |
     | 4 |                     | 4 |     | 2 | 3 | 4 |     | 2 | 3 | 4 |
     */

    override var color: SKColor {
        return Appearance.lShapeColor
    }

    override var blockRowColumnPosition: [ShapeOrientation: [(columnDiff: Int, rowDiff: Int)]] {
        return [
            .zero: [(0, 0), (1, 0), (2, 0),
                    (0, 1),
                    (0, 2)],
            .ninety: [(0, 0), (1, 0), (2, 0),
                                      (2, 1),
                                      (2, 2)],
            .oneEighty: [                (2, 0),
                                         (2, 1),
                         (0, 2), (1, 2), (2, 2)],
            .twoSeventy: [(0, 0),
                          (0, 1),
                          (0, 2), (1, 2), (2, 2)]
        ]
    }

    override var hBlocksCount: Int {
        return 3
    }

    override var vBlocksCount: Int {
        return 3
    }
}
