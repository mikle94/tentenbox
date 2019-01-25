//
//  Appearance.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/26/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import UIKit
import SpriteKit

struct Appearance {

    // offsets
    // CGPoint.y offset when user touch bottom figure
    static let figureTouchOffset: CGFloat = 50.0
    // CGPoint.x or y value to move original figure position to left/bottom/right
    static let figureDisplayOffset: CGFloat = (U.screen.width - margin * 4) / 3

    // animation
    static let figureMovementDuration: TimeInterval = 0.125
    static let lineHighlightDuration: TimeInterval = 0.3

    // ui properties
    // grid margin
    static let margin: CGFloat = 25.0
    // grid item margin
    static let itemMargin: CGFloat = 1.0
    // gaming block radius
    static let radius: CGFloat = 4.0
    // bottom figure block radius
    static let figureRadius: CGFloat = 3.0
    // bottom figure hint alpha
    static let hintFigureAlpha: CGFloat = 0.4 // 40% hint visible

    // colors
    static let sceneBackgroundColor: SKColor = R.color.black()!
    static let blockBackgroundColor: SKColor = R.color.gray()!
    static let dotShapeColor: SKColor        = R.color.lime()!
    static let squareShapeColor: SKColor     = R.color.turquoise()!
    static let cubeShapeColor: SKColor       = R.color.lightOrange()!
    static let twoLineShapeColor: SKColor    = R.color.darkOrange()!
    static let threeLineShapeColor: SKColor  = R.color.purple()!
    static let fourLineShapeColor: SKColor   = R.color.red()!
    static let fiveLineShapeColor: SKColor   = R.color.green()!
    static let cornerShapeColor: SKColor     = R.color.pink()!
    static let lShapeColor: SKColor          = R.color.blue()!
}
