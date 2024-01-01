//
//  MovieCardView.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 01/01/2024.
//

import SwiftUI

struct MovieCardView: View {
    
    @State private var isFavorite: Bool = false
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(
                url: URL(string: "https://kraftystickersapparel.com.au/cdn/shop/files/spiderman_across_the_spiderverse.jpg?v=1694397362")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 182, height: 273)
                } placeholder: {
                    ProgressView()
                        .frame(width: 182, height: 273)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.theme.primaryGray)
                        )
                }
                .cornerRadius(15)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    Button(action: {
                        // TODO: Favorite button action
                        isFavorite = !isFavorite
                    }, label: {
                        Image(isFavorite ? "heart_full_accent" : "heart_white")
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    })
                    .offset(x: -14, y: 14)
                )
            
            VStack(spacing: 10) {
                Text("Spider-Man: Across the Spider-Verse")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .lineSpacing(8)
                    .foregroundColor(Color.theme.primaryWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Jun 01, 2023")
                    .font(.callout)
                    .foregroundColor(Color.theme.primaryWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("After reuniting with Gwen Stacy, Brooklyn’s full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse, where he encounters the Spider Society, a team of Spider-People charged with protecting the Multiverse’s very existence. But when the heroes clash on how to handle a new threat, Miles finds himself pitted against the other Spiders and must set out on his own to save those he loves most.")
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
        .padding(.bottom, 20)
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
