//
//  DotShape.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/5/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit

class DotShape: Shape {

    /*
    | 0 |
    */

    override var color: SKColor {
        return .purple
    }

    override var blockRowColumnPosition: [(columnDiff: Int, rowDiff: Int)] {
        return [(0, 0)]
    }

    override var hBlocksCount: Int {
        return 1
    }

    override var vBlocksCount: Int {
        return 1
    }
}
