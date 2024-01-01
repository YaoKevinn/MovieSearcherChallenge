//
//  Color+Extension.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 30/12/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = CustomColorTheme()
}

struct CustomColorTheme {
    // MARK: - COLORS

    /// #FFFFFF
    let primaryWhite = Color("primaryWhite")

    /// #D6438C
    let accent = Color("accent")
    
    /// #111111
    let primaryBlack = Color("primaryBlack")
    
    /// #2B2B2B
    let primaryGray = Color("primaryGray")
    
    /// #888888
    let secondaryGray = Color("secondaryGray")
}
