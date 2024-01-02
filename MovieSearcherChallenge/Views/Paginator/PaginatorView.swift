//
//  PaginatorView.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 01/01/2024.
//

import SwiftUI

struct PaginatorView: View {

    var currentPage: Int
    var totalPage: Int
    var previousPageAction: (() -> Void)? = nil
    var nextPageAction: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                previousPageAction?()
            } label: {
                Text("< Previous")
                    .font(.callout)
                    .fontWeight(.medium)
                    .padding(.vertical, 16)
                    .foregroundColor(currentPage > 1 ? Color.theme.accent : Color.theme.secondaryGray)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.theme.primaryGray)
                    )
            }
            
            Text("\(currentPage)")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.primaryWhite)
            
            Button {
                nextPageAction?()
            } label: {
                Text("Next >")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(currentPage < totalPage ? Color.theme.accent : Color.theme.secondaryGray)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.theme.primaryGray)
                    )
            }
        }
        .background(Color.theme.primaryBlack)
    }
}

struct PaginatorView_Previews: PreviewProvider {
    static var previews: some View {
        PaginatorView(currentPage: 1, totalPage: 10)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
