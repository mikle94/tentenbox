//
//  ThreeLineShape.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/9/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit

class ThreeLineShape: Shape {

    /*
     | 0 | 1 | 2 |
    */

    override var color: SKColor {
        return .orange
    }

    override var blockRowColumnPosition: [(columnDiff: Int, rowDiff: Int)] {
        return [(0, 0), (1, 0), (2, 0)]
    }

    override var hBlocksCount: Int {
        return 3
    }

    override var vBlocksCount: Int {
        return 1
    }
}
