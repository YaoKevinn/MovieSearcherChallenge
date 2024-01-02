//
//  MovieDetailView.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 02/01/2024.
//

import SwiftUI

struct MovieDetailView: View {
    
    
    
    var body: some View {
        ZStack {
            Color.theme.primaryBlack.ignoresSafeArea()
            
            VStack {
                AsyncImage(url: URL(string:  "https://kraftystickersapparel.com.au/cdn/shop/files/spiderman_across_the_spiderverse.jpg?v=1694397362")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.width, height: UIScreen.height * 0.7)
                } placeholder: {
                    ProgressView()
                        .frame(width: UIScreen.width, height: UIScreen.height * 0.7)
                }
                .overlay(
                    Rectangle()
                        .fill(LinearGradient(colors: [Color.theme.primaryBlack, .clear, .clear], startPoint: .bottom, endPoint: .top))
                )

                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 10) {
                Text("Spider-Man: Across the Spider-Verse")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .lineSpacing(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Jun 01, 2023")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    Text("After reuniting with Gwen Stacy, Brooklyn’s full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse, where he encounters the Spider Society, a team of Spider-People charged with protecting the Multiverse’s very existence. But when the heroes clash on how to handle a new threat, Miles finds himself pitted against the other Spiders and must set out on his own to save those he loves most.")
                        .font(.body)
                        .lineSpacing(4)
                        .foregroundColor(Color.theme.secondaryGray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                Spacer()
                
                Button {
                   
                } label: {
                    HStack(spacing: 8) {
                        Image("heart_black")
                        Text("Add to favorite")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.primaryBlack)
                            .padding(.vertical, 13)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 28)
                            .fill(Color.theme.accent)
                    )
                }

            }
            .padding(.horizontal, 16)
            .frame(height: UIScreen.height * 0.4)
            .frame(maxWidth: UIScreen.width, maxHeight: .infinity, alignment: .bottom)
        }
        .foregroundColor(Color.theme.primaryWhite)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView()
    }
}
