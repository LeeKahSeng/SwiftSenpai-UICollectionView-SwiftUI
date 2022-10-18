//
//  PlaceholderModifier.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 15/10/2022.
//

import SwiftUI

struct PlaceholderModifier: ViewModifier {
    
    var isPlaceholder: Bool
    
    func body(content: Content) -> some View {
        if isPlaceholder {
            // Apply a redaction to current view
            content.redacted(reason: .placeholder)
        } else {
            // Do not apply any redaction to current view
            content
        }
    }
}

extension View {
    func showAsPlacehoder(_ isPlaceholder: Bool) -> some View {
        modifier(PlaceholderModifier(isPlaceholder: isPlaceholder))
    }
}
