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
                               | 0 |
                               | 1 |
     | 0 | 1 | 2 | 3 | 4 |     | 2 |
                               | 3 |
                               | 4 |
    */

    override var color: SKColor {
        return .red
    }

    override var blockRowColumnPosition: [ShapeOrientation: [(columnDiff: Int, rowDiff: Int)]] {
        let horizontalDifference: [(columnDiff: Int, rowDiff: Int)] = [(0, 0), (1, 0), (2, 0), (3, 0), (4, 0)]
        let verticalDifference: [(columnDiff: Int, rowDiff: Int)] = [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4)]
        return [
            .zero: horizontalDifference,
            .ninety: verticalDifference,
            .oneEighty: horizontalDifference,
            .twoSeventy: verticalDifference
        ]
    }

    override var hBlocksCount: Int {
        switch orientation {
        case .zero, .oneEighty:
            return 5
        case .ninety, .twoSeventy:
            return 1
        }
    }

    override var vBlocksCount: Int {
        switch orientation {
        case .zero, .oneEighty:
            return 1
        case .ninety, .twoSeventy:
            return 5
        }
    }
}
