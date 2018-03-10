//
//  TwoLineShape.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/9/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit

class TwoLineShape: Shape {

    /*
     | 0 | 1 |
     */

    override var color: SKColor {
        return .yellow
    }

    override var blockRowColumnPosition: [(columnDiff: Int, rowDiff: Int)] {
        return [(0, 0), (1, 0)]
    }

    override var hBlocksCount: Int {
        return 2
    }

    override var vBlocksCount: Int {
        return 1
    }
}
