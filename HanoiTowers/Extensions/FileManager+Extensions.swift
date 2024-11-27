//
//  FileManager+Extensions.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return URL(fileURLWithPath: paths.first!)
    }
}
