//
//  AgreementView.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 09/04/2023.
//

import SwiftUI

struct AgreementView: View {
    
    class ViewState: ObservableObject {
        @Published var isChecked = false
    }
    
    /// ObservableObject to keep track of the current check status
    @ObservedObject var currentViewState = ViewState()
    
    @State private var fontSize = 16.0
    @State private var isBold = false
    
    var body: some View {
        Text("I have read and agree to Apple's [User Agreement](https://www.apple.com/legal/internet-services/itunes/dev/stdeula/) and [Privacy Policy](https://www.apple.com/legal/privacy/en-ww/)")
            .font(.system(size: fontSize))
            .bold(isBold)
            .onReceive(currentViewState.$isChecked) { checked in
                // Animate based on the check status
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
                    fontSize = checked ? 18.0 : 16.0
                    isBold = checked
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
    
    func setIsChecked(_ isChecked: Bool) {
        // Update current check status
        currentViewState.isChecked = isChecked
    }
}

