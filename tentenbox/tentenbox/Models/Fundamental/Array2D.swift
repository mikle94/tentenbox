//
//  Array2D.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/2/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import Foundation

struct Array2D<T> {

    let columns: Int
    let rows: Int
    fileprivate var array: [T?]

    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = [T?](repeating: nil, count: rows * columns)
    }

    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row * columns + column]
        }
        set {
            array[row * columns + column] = newValue
        }
    }
}
