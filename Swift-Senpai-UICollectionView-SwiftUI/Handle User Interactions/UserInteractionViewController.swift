//
//  UserInteractionViewController.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 13/08/2022.
//

import UIKit
import SwiftUI

class UserInteractionViewController: UIViewController {

    var collectionView: UICollectionView!

    let dataModel = [
        SFSymbolItem(name: "applelogo"),
        SFSymbolItem(name: "iphone"),
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

    private var userInteractionCellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, SFSymbolItem>!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Handle User Interactions"

        // Create cell registration
        userInteractionCellRegistration = .init { [unowned self] cell, indexPath, item in

            cell.configurationUpdateHandler = { [unowned self] cell, state in
                cell.contentConfiguration = createHostingConfiguration(for: item, with: state)

                var newBgConfiguration = UIBackgroundConfiguration.listGroupedCell()
                newBgConfiguration.backgroundColor = .systemBackground
                cell.backgroundConfiguration = newBgConfiguration
            }
        }

        // Configure collection view using list layout
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        collectionView.dataSource = self
        view = collectionView
    }

    /// Create a content configuration that host the `UserInteractionCell`
    private func createHostingConfiguration(
        for item: SFSymbolItem,
        with state: UICellConfigurationState
    ) -> UIHostingConfiguration<some View, EmptyView> {

        return UIHostingConfiguration {


            UserInteractionCell(item: item, state: state)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) { [unowned self] in
                        showAlert(title: "Delete", message: item.name)
                    } label: {
                        Label("", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading) {

                    Button("SHARE") { [unowned self] in
                        showAlert(title: "Share", message: item.name)
                    }
                    .tint(.green)

                    Button { [unowned self] in
                        showAlert(title: "Favorite", message: item.name)
                    } label: {
                        Label("", systemImage: "star")
                    }
                    .tint(.yellow)
                }
        }
    }

    private func showAlert(title: String, message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let positiveAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(positiveAction)

        present(alert, animated: true)
    }
}

extension UserInteractionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = dataModel[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(using: userInteractionCellRegistration,
                                                                for: indexPath,
                                                                item: item)

        return cell
    }
}
