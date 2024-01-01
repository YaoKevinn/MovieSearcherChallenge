//
//  Image+Extension.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 01/01/2024.
//

import Foundation
import SwiftUI

extension Image {
    func resizeImage(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
   }
}
