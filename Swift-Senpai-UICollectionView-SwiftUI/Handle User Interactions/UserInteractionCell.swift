//
//  UserInteractionCell.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 15/08/2022.
//

import SwiftUI
import UIKit

struct UserInteractionCell: View {

    var item: SFSymbolItem
    
    /// Variable that represents the view state
    var state: UICellConfigurationState

    var body: some View {

        HStack(alignment: .center, spacing: 8) {

            Image(systemName: item.name)
                // Change SFSymbol styling based on state
                .font(state.isSelected ? .title2 : .body)
                .foregroundColor(state.isSelected ? Color(.systemRed) : Color(.label))

            Text(item.name)
                // Change text styling based on state
                .font(Font.headline.weight(state.isSelected ? .bold : .regular))
                .foregroundColor(state.isSelected ? Color(.systemRed) : Color(.label))

            Spacer()
        }
    }
}
