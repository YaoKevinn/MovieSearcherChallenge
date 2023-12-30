//
//  UIScreen+Extension.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 30/12/2023.
//

import Foundation
import SwiftUI

extension UIScreen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let topSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    static let bottomSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
}
