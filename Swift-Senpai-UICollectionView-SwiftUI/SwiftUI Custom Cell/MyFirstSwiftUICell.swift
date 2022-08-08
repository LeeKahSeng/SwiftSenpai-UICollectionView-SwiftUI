//
//  MyFirstSwiftUICell.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 06/08/2022.
//

import SwiftUI

struct MyFirstSwiftUICell: View {
    
    var item: SFSymbolItem
    
    var body: some View {
        
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: item.name)
                .padding()
            Spacer()
            Text(item.name)
                .font(.system(.title3, weight: .semibold))
            Spacer()
            Image(systemName: item.name)
                .padding()
        }
        .frame(height: 70)
        .background {
            RoundedRectangle(cornerRadius: 12.0)
                .fill(Color(.systemYellow))
        }
        .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
        .alignmentGuide(.listRowSeparatorTrailing) { $0[.trailing] }
    }
}

