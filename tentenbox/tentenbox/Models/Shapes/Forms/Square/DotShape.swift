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
        return Appearance.dotShapeColor
    }

    override var blockRowColumnPosition: [ShapeOrientation: [(columnDiff: Int, rowDiff: Int)]] {
        let differences: [(columnDiff: Int, rowDiff: Int)] = [(0, 0)]
        return [.zero: differences, .ninety: differences, .oneEighty: differences, .twoSeventy: differences]
    }

    override var hBlocksCount: Int {
        return 1
    }

    override var vBlocksCount: Int {
        return 1
    }
}
