//
//  PlaceholderCellViewController.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 10/10/2022.
//

import UIKit
import SwiftUI

struct Quote {
    let symbol: String
    let content: String
    let author: String
}

class PlaceholderCellViewController: UIViewController {

    /// Data to show on screen
    private var onScreenData = [Quote]()
    
    private var collectionView: UICollectionView!
    private var quoteCellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, Quote>!
    private let refreshControl = UIRefreshControl()
    private var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define cell registration
        quoteCellRegistration = .init { cell, indexPath, item in
            
            let hostingConfiguration = UIHostingConfiguration { [unowned self] in
                QuoteCell(item: item, isLoading: self.isLoading)
            }.margins(.horizontal, 20)
            
            // Make hosting configuration as the cell's content configuration
            cell.contentConfiguration = hostingConfiguration
        }
        
        // Configure collection view using list layout
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfig.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        collectionView.dataSource = self
        view = collectionView
        
        // Setup refresh control
        refreshControl.addTarget(self, action: #selector(performReload), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        // Fetch data from data provider
        performReload()
    }
    
    @objc func performReload() {
        
        isLoading = true
        refreshControl.beginRefreshing()
        
        // Load the collection view with dummy data
        onScreenData = DataProvider.dummyData
        collectionView.reloadData()
        
        Task {
            // Load the collection view with data from data provider
            onScreenData = await DataProvider.fetchData()
            collectionView.reloadData()
            
            refreshControl.endRefreshing()
            isLoading = false
        }
    }

}

// MARK: - UICollectionViewDataSource
extension PlaceholderCellViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onScreenData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = onScreenData[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: quoteCellRegistration,
            for: indexPath,
            item: item
        )

        return cell
    }
}
