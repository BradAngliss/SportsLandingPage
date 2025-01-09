//
//  ImageValues.swift
//  SnackbarDemo
//
//  Created by Brad Angliss on 16/05/2024.
//

import Foundation
import SwiftUI

public struct ImageValues: Hashable {
    private(set) var text: String
    private(set) var textOffset: CGSize
    private(set) var image: String
    private(set) var offsetX: CGFloat
    private(set) var offsetY: CGFloat
    private(set) var background: Color
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
}
