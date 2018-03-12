//
//  Block.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/2/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit

class Block: Hashable {

    var column: Int
    var row: Int
    var node: SKSpriteNode?
    var color: SKColor

    init(column: Int, row: Int) {
        self.column = column
        self.row = row
        self.color = C.Appearance.blockColor
    }

    // MARK: Hashable protocol conformation
    var hashValue: Int {
        return row * 10 + column
    }
}

func == (lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}
