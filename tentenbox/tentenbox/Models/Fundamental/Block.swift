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
    var type: BlockType

    var nodeColor: SKColor {
        switch type {
        case .background:
            return C.Appearance.blockColor
        case .empty:
            return .clear
        case .hint:
            return color.withAlphaComponent(0.4)
        case .real:
            return color
        }
    }

    var isHintAvailable: Bool {
        return type != .background && type != .real
    }

    init(column: Int, row: Int, color: SKColor = C.Appearance.blockColor, type: BlockType = .background) {
        self.column = column
        self.row = row
        self.color = color
        self.type = type
    }

    // MARK: Hashable protocol conformation
    var hashValue: Int {
        return row * 10 + column
    }
}

enum BlockType: Int {
    case background = 0, empty, hint, real
}

func == (lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}
