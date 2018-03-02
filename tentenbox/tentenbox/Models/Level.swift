//
//  Level.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/2/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import Foundation

class Level {

    fileprivate var blocks = Array2D<Block>(columns: C.Game.numberOfColumns, rows: C.Game.numberOfRows)

    func blockAt(column: Int, row: Int) -> Block? {
        assert(column >= 0 && column < C.Game.numberOfColumns)
        assert(row >= 0 && row < C.Game.numberOfRows)
        return blocks[column, row]
    }

    func getStartingBlocks() -> Set<Block> {
        return createInitialBlocks()
    }

    private func createInitialBlocks() -> Set<Block> {
        var set = Set<Block>()
        for row in 0 ..< C.Game.numberOfRows {
            for column in 0 ..< C.Game.numberOfColumns {
                let block = Block(column: column, row: row)
                blocks[column, row] = block
                set.insert(block)
            }
        }
        return set
    }
}
