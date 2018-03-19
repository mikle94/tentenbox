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

    override var blockRowColumnPosition: [ShapeOrientation: [(columnDiff: Int, rowDiff: Int)]] {
        return [
            .zero: [(0, 0), (1, 0)],
            .ninety: [(0, 0), (0, 1)]
        ]
    }

    override var hBlocksCount: Int {
        switch orientation {
        case .zero:
            return 2
        case .ninety:
            return 1
        }
    }

    override var vBlocksCount: Int {
        switch orientation {
        case .zero:
            return 1
        case .ninety:
            return 2
        }
    }
}
