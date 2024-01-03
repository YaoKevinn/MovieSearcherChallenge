//
//  OfflineView.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 03/01/2024.
//

import SwiftUI

struct OfflineView: View {
    
    var action: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Color.theme.primaryBlack.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("No internet connection detected")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.theme.secondaryGray)
                
                Button {
                    action?()
                } label: {
                    Text("Go to offline mode")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.primaryWhite)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.theme.accent)
                        )
                }
                
                Spacer()
            }
            .padding(20)
        }
    }
}

struct OfflineView_Previews: PreviewProvider {
    static var previews: some View {
        OfflineView()
    }
}
