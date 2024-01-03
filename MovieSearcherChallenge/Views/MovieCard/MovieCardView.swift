//
//  MovieCardView.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 01/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCardView: View {
    
    let movie: MovieDTO
    @State private var isFavorite: Bool = false
    var onTapCard: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 15) {
            if let data = movie.image, let uiImage = UIImage(data: data) {
               Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 182, height: 273)
                    .cornerRadius(15)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(
                        Button(action: {
                            // TODO: Favorite button action
                            isFavorite = !isFavorite
                        }, label: {
                            Image(isFavorite ? "heart_full_accent" : "heart_white")
                                .resizeImage(width: 28, height: 28)
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .offset(x: -14, y: 14)
                    )
            } else {
                Image("image_unavailable")
                    .frame(width: 182, height: 273)
                    .cornerRadius(15)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.theme.primaryGray)
                    )
                    .overlay(
                        Button(action: {
                            // TODO: Favorite button action
                            isFavorite = !isFavorite
                        }, label: {
                            Image(isFavorite ? "heart_full_accent" : "heart_white")
                                .resizeImage(width: 28, height: 28)
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .offset(x: -14, y: 14)
                    )
            }
            
            VStack(spacing: 10) {
                Text(movie.title)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .lineSpacing(8)
                    .foregroundColor(Color.theme.primaryWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(movie.releaseDate)
                    .font(.callout)
                    .foregroundColor(Color.theme.primaryWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(movie.overview)
                    .font(.caption)
                    .lineLimit(5)
                    .lineSpacing(4)
                    .foregroundColor(Color.theme.secondaryGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
        }
        .background(Color.theme.primaryBlack)
        .frame(height: 273)
        .onTapGesture {
            onTapCard?()
        }
        .padding(.bottom, 20)
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: MovieDTO.dummy())
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
