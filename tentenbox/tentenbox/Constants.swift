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
        static let numberOfRows: Int = 10
        static let numberOfColumns: Int = 10

        static let blockWidth: CGFloat = (U.screen.width - Appearance.margin * 2 - Appearance.itemMargin * CGFloat(numberOfRows - 1)) / CGFloat(numberOfRows)
        static let blockHeight: CGFloat = blockWidth
        static let figureBlockWidth: CGFloat = {
            let availableAreaWidth = (U.screen.width - C.Appearance.margin * 4) / 3 - C.Appearance.itemMargin * CGFloat(shapeMaxHorizontalBlockCount - 1)
            return availableAreaWidth / CGFloat(shapeMaxHorizontalBlockCount)
        }()
        static let figureBlockHeight: CGFloat = figureBlockWidth

        static let numberOfShapes: Int = 7
        static let shapeMaxHorizontalBlockCount: Int = 5
    }

    struct Appearance {
        static let margin: CGFloat = 25.0
        static let itemMargin: CGFloat = 1.0

        static let radius: CGFloat = 4.0

        static let figureRadius: CGFloat = 3.0
        static let figureTouchOffset: CGFloat = 50.0

        static let sceneBackgroundColor: SKColor = .darkGray
        static let blockColor: SKColor = .gray
    }

    struct Name {
        static let bottomFigure: String          = "bottomFigure"
        static let bottomFigureBlock: String     = "bottomFigureBlock"
        static let bottomFigureContainer: String = "bottomFigureContainer"
    }
}
