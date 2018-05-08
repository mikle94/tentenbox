//
//  Constants.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/2/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import UIKit
import SpriteKit

typealias C = Constants
struct Constants {

    struct Game {
        // game settings
        static let numberOfRows: Int = 10
        static let numberOfColumns: Int = 10
        static let numberOfShapes: Int = 9
        static let shapeMaxHorizontalBlockCount: Int = 5
        // main block size
        static let blockSize: CGFloat = (U.screen.width - Appearance.margin * 2 - Appearance.itemMargin * CGFloat(numberOfRows - 1)) / CGFloat(numberOfRows)
        // bottom block size
        static let figureBlockSize: CGFloat = {
            let availableAreaWidth = (U.screen.width - Appearance.margin * 4) / 3 - Appearance.itemMargin * CGFloat(shapeMaxHorizontalBlockCount - 1)
            return availableAreaWidth / CGFloat(shapeMaxHorizontalBlockCount)
        }()
        // touches block size
        static let touchedBlockSize: CGFloat = C.Game.blockSize * 0.9 // 90% of main block
    }

    struct Name {
        // node names
        static let bottomFigure: String          = "bottomFigure"
        static let bottomFigureBlock: String     = "bottomFigureBlock"
        static let bottomFigureContainer: String = "bottomFigureContainer"
    }
}
