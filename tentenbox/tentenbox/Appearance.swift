//
//  Appearance.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/26/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import UIKit
import SpriteKit
import ChameleonFramework

struct Appearance {

    // offsets
    // CGPoint.y offset when user touch bottom figure
    static let figureTouchOffset: CGFloat = 50.0
    // CGPoint x or y value to move original figure position to left/bottom/right
    static let figureDisplayOffset: CGFloat = (U.screen.width - margin * 4) / 3

    // animation
    static let figureMovementDuration: TimeInterval = 0.125
    static let lineHighlightDuration: TimeInterval = 0.3

    // ui properties
    static let margin: CGFloat = 25.0                           // grid margin
    static let itemMargin: CGFloat = 1.0                        // grid item margin

    static let radius: CGFloat = 4.0                            // gaming block radius
    static let figureRadius: CGFloat = 3.0                      // bottom figure block radius

    static let hintFigureAlpha: CGFloat = 0.4                   // 40% hint visible

    // colors
    static let sceneBackgroundColor: SKColor = UIColor(hexString: "#57606f") ?? .clear
    static let blockBackgroundColor: SKColor = UIColor(hexString: "#a4b0be") ?? .clear
    static let dotShapeColor: SKColor        = UIColor(hexString: "#eccc68") ?? .clear
    static let squareShapeColor: SKColor     = UIColor(hexString: "#ffa502") ?? .clear
    static let cubeShapeColor: SKColor       = UIColor(hexString: "#7bed9f") ?? .clear
    static let twoLineShapeColor: SKColor    = UIColor(hexString: "#70a1ff") ?? .clear
    static let threeLineShapeColor: SKColor  = UIColor(hexString: "#ff6348") ?? .clear
    static let fourLineShapeColor: SKColor   = UIColor(hexString: "#ff6b81") ?? .clear
    static let fiveLineShapeColor: SKColor   = UIColor(hexString: "#ff4757") ?? .clear
    static let cornerShapeColor: SKColor     = UIColor(hexString: "#ff7f50") ?? .clear
    static let lShapeColor: SKColor          = UIColor(hexString: "#5352ed") ?? .clear
}
