//
//  PaginatorView.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 01/01/2024.
//

import SwiftUI

struct PaginatorView: View {
    
    @Binding var isPreviousAvailable: Bool
    @Binding var isNextAvailable: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Text("< Previous")
                .font(.callout)
                .fontWeight(.medium)
                .padding(.vertical, 16)
                .foregroundColor(isPreviousAvailable ? Color.theme.accent : Color.theme.secondaryGray)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.theme.primaryGray)
                )
            
            Text("Next >")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(isNextAvailable ? Color.theme.accent : Color.theme.secondaryGray)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.theme.primaryGray)
                )
                
        }
        .background(Color.theme.primaryBlack)
    }
}

struct PaginatorView_Previews: PreviewProvider {
    static var previews: some View {
        PaginatorView(isPreviousAvailable: .constant(false), isNextAvailable: .constant(true))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
