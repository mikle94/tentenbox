//
//  Calculation.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/13/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import UIKit

class Calculation {

    // MARK: Calculation Functions

    static func pointFor(column: Int, row: Int, size: CGSize) -> CGPoint {
        return CGPoint(
            x: size.width * CGFloat(column) + C.Appearance.itemMargin * CGFloat(column) + size.width / 2,
            y: size.height * CGFloat(row) + C.Appearance.itemMargin * CGFloat(row) + size.height / 2
        )
    }

    // calculate rect for figure's shape
    static func rect(for shape: Shape) -> CGRect {
        let width = CGFloat(shape.hBlocksCount) * C.Game.figureBlockSize + CGFloat(shape.hBlocksCount - 1) * C.Appearance.itemMargin
        let height = CGFloat(shape.vBlocksCount) * C.Game.figureBlockSize + CGFloat(shape.vBlocksCount - 1) * C.Appearance.itemMargin
        return CGRect(x: 0.0, y: 0.0, width: width, height: height)
    }

    // calculate position for figure
    static func position(for figure: BottomFigure, frame: CGRect, adjusted: Bool = false) -> CGPoint {
        let rect = containerRect(for: figure)
        var point = CGPoint(
            x: rect.width / 2 - frame.width / 2,
            y: rect.width / 2 - frame.height / 2
        )
        switch figure {
        case .left:
            point.x -= adjusted ? C.Appearance.figureDisplayOffset : 0
        case .middle:
            point.y -= adjusted ? C.Appearance.figureDisplayOffset : 0
        case .right:
            point.x += adjusted ? C.Appearance.figureDisplayOffset : 0
        }
        return point
    }

    // calculate rect for figure container
    static func containerRect(for: BottomFigure) -> CGRect {
        let width = (U.screen.width - C.Appearance.margin * 4) / 3
        return CGRect(origin: .zero, size: CGSize(width: width, height: width))
    }

    // calculate position for figure container
    static func containerPosition(for figure: BottomFigure) -> CGPoint {
        let width = (U.screen.width - C.Appearance.margin * 4) / 3
        return CGPoint(
            x: C.Appearance.margin * CGFloat(figure.rawValue + 1) + width * CGFloat(figure.rawValue),
            y: GameScene.blocksLayerPosition.y - width - C.Appearance.margin * 2
        )
    }

}
