//
//  Utils.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/2/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import UIKit

typealias U = Utils
class Utils {
    // screen rect
    static let screen: CGRect             = mainScreen.bounds
    // main screen
    static let mainScreen: UIScreen       = .main
    // user defaults
    static let defaults: UserDefaults     = .standard
    // application
    static let application: UIApplication = .shared
    // status bar height
    static let statusBarHeight: CGFloat   = U.application.statusBarFrame.height
}

// custom print function
func p(_ items: Any..., filepath: String = #file, function: String = #function, line: Int = #line, separator: String = " ", terminator: String = "\n") {
    struct Counter {
        static var value: Int = 0
    }
    Counter.value += 1
    let url = URL(fileURLWithPath: filepath)
    let fileName: String = url.lastPathComponent.isEmpty ? filepath : url.lastPathComponent
    let thread = Thread.current.isMainThread ? "On Main Thread" : (Thread.current.name ?? "On Unknown Thread")
    Swift.print("Print \(Counter.value):")
    Swift.print(thread)
    Swift.print("\(fileName): \(function) - line \(line)")
    for i in 0 ..< items.count {
        Swift.print(items[i], separator: separator, terminator: i == items.count - 1 ? terminator : separator)
    }
    Swift.print("\n")
}

// delay function
func delay(for seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}
