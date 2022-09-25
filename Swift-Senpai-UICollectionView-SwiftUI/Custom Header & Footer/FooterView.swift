//
//  FooterView.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 21/09/2022.
//

import SwiftUI

struct FooterView: View {
    
    @ObservedObject var section: SymbolSection
    
    var body: some View {

        Text(section.selectedCellIndex == nil ?
             "Selected: ---" : "Selected: \(section.symbols[section.selectedCellIndex!].name)")
        .font(.system(.footnote, weight: .semibold))
        .foregroundColor(Color(.darkGray))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom)
    }
}
