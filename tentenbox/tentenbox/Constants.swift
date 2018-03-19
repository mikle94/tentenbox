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
        static let numberOfShapes: Int = 7
        static let shapeMaxHorizontalBlockCount: Int = 5
        // main block size
        static let blockSize: CGFloat = (U.screen.width - Appearance.margin * 2 - Appearance.itemMargin * CGFloat(numberOfRows - 1)) / CGFloat(numberOfRows)
        // bottom block size
        static let figureBlockSize: CGFloat = {
            let availableAreaWidth = (U.screen.width - C.Appearance.margin * 4) / 3 - C.Appearance.itemMargin * CGFloat(shapeMaxHorizontalBlockCount - 1)
            return availableAreaWidth / CGFloat(shapeMaxHorizontalBlockCount)
        }()
        // touches block size
        static let touchedBlockSize: CGFloat = C.Game.blockSize * 0.9 // 90% of main block
    }

    struct Appearance {
        // ui properties
        static let margin: CGFloat = 25.0 // grid margin
        static let itemMargin: CGFloat = 1.0 // grid item margin

        static let radius: CGFloat = 4.0 // gaming block radius
        static let figureRadius: CGFloat = 3.0 // bottom figure block radius

        static let hintFigureAlpha: CGFloat = 0.4 // 40% hint visible

        // offsets
        // CGPoint.y offset when user touch bottom figure
        static let figureTouchOffset: CGFloat = 50.0
        // CGPoint x or y value to move original figure position to left/bottom/right
        static let figureDisplayOffset: CGFloat = (U.screen.width - C.Appearance.margin * 4) / 3

        // animation
        static let figureMovementDuration: TimeInterval = 0.125
        static let lineHighlightDuration: TimeInterval = 0.3

        // colors
        static let sceneBackgroundColor: SKColor = .darkGray
        static let blockColor: SKColor = .gray
    }

    struct Name {
        // node names
        static let bottomFigure: String          = "bottomFigure"
        static let bottomFigureBlock: String     = "bottomFigureBlock"
        static let bottomFigureContainer: String = "bottomFigureContainer"
    }
}
