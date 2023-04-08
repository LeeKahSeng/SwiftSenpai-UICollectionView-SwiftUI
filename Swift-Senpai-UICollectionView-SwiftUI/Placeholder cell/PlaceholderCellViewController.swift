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

    /// Data to show in collection view
    private var collectionViewData = [Quote]()
    
    private var collectionView: UICollectionView!
    private var quoteCellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, Quote>!
    private let refreshControl = UIRefreshControl()
    private var isLoading = true
    
    /// Dummy data needed for placeholder cells
    /// Note: The content of `Quote` is not important, we just need some text to generate the placeholder UI.
    let dummyData = [
        Quote(symbol: "iphone", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore", author: "Author name"),
        Quote(symbol: "iphone", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore", author: "Author name"),
        Quote(symbol: "iphone", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore", author: "Author name"),
        Quote(symbol: "iphone", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore", author: "Author name"),
    ]
    
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
        refreshControl.addTarget(self, action: #selector(performPullToRefresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        // Fetch data from data provider
        performPullToRefresh()
    }
    
    @objc func performPullToRefresh() {
        
        refreshControl.beginRefreshing()
        
        // Load the collection view with dummy data
        isLoading = true
        collectionViewData = dummyData
        collectionView.reloadData()
        
        Task {
            // Load the collection view with data from data provider
            collectionViewData = await DataProvider.fetchData()
            collectionView.reloadData()
            isLoading = false
            
            refreshControl.endRefreshing()
        }
    }

}

// MARK: - UICollectionViewDataSource
extension PlaceholderCellViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = collectionViewData[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: quoteCellRegistration,
            for: indexPath,
            item: item
        )

        return cell
    }
}
