//
//  SwiftUICustomCellViewController.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 06/08/2022.
//

import UIKit
import SwiftUI

class SwiftUICustomCellViewController: UIViewController {

    var collectionView: UICollectionView!
    
    let dataModel = [
        SFSymbolItem(name: "applelogo"),
        SFSymbolItem(name: "iphone"),
        SFSymbolItem(name: "message"),
        SFSymbolItem(name: "message.fill"),
        SFSymbolItem(name: "sun.min"),
        SFSymbolItem(name: "sun.min.fill"),
        SFSymbolItem(name: "sunset"),
        SFSymbolItem(name: "sunset.fill"),
        SFSymbolItem(name: "pencil"),
        SFSymbolItem(name: "pencil.circle"),
        SFSymbolItem(name: "highlighter"),
        SFSymbolItem(name: "network"),
        SFSymbolItem(name: "icloud"),
        SFSymbolItem(name: "icloud.fill"),
        SFSymbolItem(name: "car"),
        SFSymbolItem(name: "car.fill"),
        SFSymbolItem(name: "bus"),
        SFSymbolItem(name: "bus.fill"),
        SFSymbolItem(name: "flame"),
        SFSymbolItem(name: "flame.fill"),
        SFSymbolItem(name: "bolt"),
        SFSymbolItem(name: "bolt.fill")
    ]
    
    private var swiftUICellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, SFSymbolItem> = {
        .init { cell, indexPath, item in
            
            let hostingConfiguration = UIHostingConfiguration {
                MyFirstSwiftUICell(item: item)
            }.margins(.horizontal, 50)
            
            // Make hosting configuration as the cell's content configuration
            cell.contentConfiguration = hostingConfiguration
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SwiftUI Custom Cell"
        
        // Configure collection view using list layout
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        collectionView.dataSource = self
        view = collectionView

    }
}

extension SwiftUICustomCellViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = dataModel[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(using: swiftUICellRegistration, for: indexPath, item: item)
        
        return cell
    }
}




