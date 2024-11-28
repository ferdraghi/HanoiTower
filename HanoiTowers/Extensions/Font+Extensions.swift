//
//  Font+Extensions.swift
//  HanoiTowers
//
//  Created by Fernando Draghi on 27/11/2024.
//

import SwiftUI

extension Font {
    public static var gameFont: Font { .gameFont(size: 25) }
    
    public static func gameFont(size: CGFloat) -> Font {
        .system(size: size, weight: .heavy, design: .rounded)
    }
}
