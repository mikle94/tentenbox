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
    }

    struct Appearance {
        static let margin: CGFloat = 25.0
        static let itemMargin: CGFloat = U.mainScreen.scale * 1.0 / 2
        static let radius: CGFloat = 5.0

        static let sceneBackgroundColor: SKColor = .darkGray
        static let blockColor: SKColor = .gray
    }
}
