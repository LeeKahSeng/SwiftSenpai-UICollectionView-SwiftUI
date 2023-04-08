//
//  QuoteCell.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 15/10/2022.
//

import SwiftUI

struct QuoteCell: View {

    var item: Quote
    var isLoading: Bool
    
    var body: some View {
   
        VStack(spacing: 12) {
            Image(systemName: item.symbol)
                .imageScale(.large)
                .fontWeight(.bold)
                .padding()
                .background {
                    Circle()
                        .fill(Color(.secondarySystemFill))
                }
            Text(item.content)
                .fontWeight(.bold)
            Text("- \(item.author)")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.footnote)
                .italic()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12.0)
                .fill(Color(.systemFill))
        }
        .showAsPlacehoder(isLoading)
    }
}
