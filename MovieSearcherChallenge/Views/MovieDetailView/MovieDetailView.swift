//
//  MovieDetailView.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 02/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    
    let movie: MovieDTO
    var toggleFavoriteAction: (() -> Void)? = nil
    
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.primaryBlack.ignoresSafeArea()
            
            VStack {
                if let data = movie.image, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.width, height: UIScreen.height * 0.7)
                        .overlay(
                            Rectangle()
                                .fill(LinearGradient(colors: [Color.theme.primaryBlack, .clear, .clear], startPoint: .bottom, endPoint: .top))
                        )
                } else {
                    Image("image_unavailable")
                        .frame(width: UIScreen.width, height: UIScreen.height * 0.7)
                        .overlay(
                            Rectangle()
                                .fill(LinearGradient(colors: [Color.theme.primaryBlack, .clear, .clear], startPoint: .bottom, endPoint: .top))
                        )
                }

                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 10) {
                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .lineSpacing(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(movie.releaseDate)
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    Text(movie.overview)
                        .font(.body)
                        .lineSpacing(4)
                        .foregroundColor(Color.theme.secondaryGray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                Spacer()
                
                Button {
                    toggleFavorite()
                } label: {
                    HStack(spacing: 8) {
                        Image("heart_black")
                        Text(isFavorite ? "Remove form favorite" : "Add to favorite")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.primaryBlack)
                            .padding(.vertical, 13)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 28)
                            .fill(isFavorite ? Color.theme.primaryWhite : Color.theme.accent)
                    )
                }

            }
            .padding(.horizontal, 16)
            .frame(height: UIScreen.height * 0.4)
            .frame(maxWidth: UIScreen.width, maxHeight: .infinity, alignment: .bottom)
        }
        .foregroundColor(Color.theme.primaryWhite)
        .onAppear {
            if let favoriteIds = UserDefaults.standard.array(forKey: "favoritesMovieIds") as? [Int] {
                isFavorite = favoriteIds.contains(movie.id)
            }
        }
    }
    
    private func toggleFavorite() {
        if let favIds = UserDefaults.standard.array(forKey: "favoritesMovieIds") as? [Int] {
            var newFavIds = favIds
            if newFavIds.contains(movie.id) {
                newFavIds.removeAll(where: { $0 == movie.id })
            } else {
                newFavIds.append(movie.id)
            }
            UserDefaults.standard.set(newFavIds, forKey: "favoritesMovieIds")
        } else {
            UserDefaults.standard.set([movie.id], forKey: "favoritesMovieIds")
        }
       isFavorite.toggle()
       toggleFavoriteAction?()
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MovieDTO.dummy())
    }
}
