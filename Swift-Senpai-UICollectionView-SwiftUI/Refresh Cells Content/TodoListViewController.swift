//
//  TodoListViewController.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 05/09/2022.
//

import UIKit
import SwiftUI

class TodoItem: ObservableObject {

    let title: String
    @Published var completed: Bool

    init(_ title: String) {
        self.title = title
        self.completed = false
    }
}


class TodoListViewController: UIViewController {

    var collectionView: UICollectionView!
    private var todoListCellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, TodoItem>!

    let todoItems = [
        TodoItem("Write a blog post"),
        TodoItem("Call John"),
        TodoItem("Make doctor's appointment"),
        TodoItem("Reply emails"),
        TodoItem("Buy Lego for Jimmy"),
        TodoItem("Get a hair cut"),
        TodoItem("Book flight to Japan"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create cell registration
        todoListCellRegistration = .init { cell, indexPath, item in

            cell.contentConfiguration = UIHostingConfiguration {
                TodoListCell(item: item)
            }

            var newBgConfiguration = UIBackgroundConfiguration.listGroupedCell()
            newBgConfiguration.backgroundColor = .systemBackground
            cell.backgroundConfiguration = newBgConfiguration
        }

        // Configure collection view using list layout
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfig.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        collectionView.dataSource = self
        view = collectionView

        // Add "Complete All" button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Complete All",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(completeAllTapped))
    }

    @objc private func completeAllTapped() {
        // Update all elements to `completed = true`
        for item in todoItems {
            item.completed = true
        }
    }
}

extension TodoListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = todoItems[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: todoListCellRegistration,
            for: indexPath,
            item: item
        )

        return cell
    }
}
