//
//  HeaderView.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 01/01/2024.
//

import SwiftUI

struct HeaderView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                Text("Explore Movie")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Color.theme.primaryWhite)
                Text(".")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.accent)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("favorite_list")
                        .resizeImage(width: 28, height: 28)
                }
                .zIndex(999)
            }
            
            HStack(spacing: 16) {
                Image("search")
                    .resizeImage(width: 20, height: 20)
                
                TextField("", text: $searchText)
                    .placeholder(when: searchText.isEmpty) {
                            Text("Search a movie")
                            .foregroundColor(Color.theme.primaryWhite.opacity(0.2))
                    }
                    .font(.headline)
                    .foregroundColor(Color.theme.primaryWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 25)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.primaryGray)
                    
            )
            
            Text("Search results for \"Example\"")
                .font(.headline)
                .foregroundColor(Color.theme.primaryWhite)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
        .background(Color.theme.primaryBlack)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
