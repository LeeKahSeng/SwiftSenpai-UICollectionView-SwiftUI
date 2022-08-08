//
//  SwiftUICustomCellViewController.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 06/08/2022.
//

import Foundation
import UIKit

enum Section {
    case main
}

struct SFSymbolItem: Hashable {
    let name: String
    let image: UIImage
    
    init(name: String) {
        self.name = name
        self.image = UIImage(systemName: name)!
    }
}
