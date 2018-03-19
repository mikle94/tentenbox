//
//  CubeShape.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/9/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit

class CubeShape: Shape {

    /*
     | 0 | 1 | 2 |
     | 3 | 4 | 5 |
     | 6 | 7 | 8 |
     */

    override var color: SKColor {
        return .cyan
    }

    override var blockRowColumnPosition: [ShapeOrientation: [(columnDiff: Int, rowDiff: Int)]] {
        let differences: [(columnDiff: Int, rowDiff: Int)] = [
            (0, 0), (1, 0), (2, 0),
            (0, 1), (1, 1), (2, 1),
            (0, 2), (1, 2), (2, 2)
        ]
        return [.zero: differences, .ninety: differences, .oneEighty: differences, .twoSeventy: differences]
    }

    override var hBlocksCount: Int {
        return 3
    }

    override var vBlocksCount: Int {
        return 3
    }
}
