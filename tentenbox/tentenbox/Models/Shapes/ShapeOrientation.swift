//
//  ShapeOrientation.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/19/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import Foundation

enum ShapeOrientation: Int {

    case zero = 0, ninety

    static let count: Int = {
        var max: Int = 0
        while let _ = ShapeOrientation(rawValue: max) { max += 1 }
        return max
    }()

    static func random() -> ShapeOrientation {
        let randomValue = Int(arc4random_uniform(UInt32(count)))
        switch randomValue {
        case 0:
            return .zero
        default:
            return .ninety
        }
    }

}
