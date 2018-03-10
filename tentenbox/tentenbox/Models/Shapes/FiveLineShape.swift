//
//  FiveLineShape.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/9/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit

class FiveLineShape: Shape {

    /*
     | 0 | 1 | 2 | 3 | 4 |
    */

    override var color: SKColor {
        return .red
    }

    override var blockRowColumnPosition: [(columnDiff: Int, rowDiff: Int)] {
        return [(0, 0), (1, 0), (2, 0), (3, 0), (4, 0)]
    }

    override var hBlocksCount: Int {
        return 5
    }

    override var vBlocksCount: Int {
        return 1
    }
}
