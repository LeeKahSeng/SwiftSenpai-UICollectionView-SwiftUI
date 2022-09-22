//
//  HeaderFooterViewController.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 20/09/2022.
//

import UIKit
import SwiftUI

class SymbolSection: ObservableObject {
    let title: String
    let symbols: [SFSymbolItem]
    @Published var selectedCellIndex: Int?
    
    init(title: String, symbols: [SFSymbolItem]) {
        self.title = title
        self.symbols = symbols
    }
}

class HeaderFooterViewController: UIViewController {
    
    var collectionView: UICollectionView!
    private var symbolCellRegistration: UICollectionView.CellRegistration<UICollectionViewCell, SFSymbolItem>!
    private var headerRegistration: UICollectionView.SupplementaryRegistration<UICollectionViewCell>!
    private var footerRegistration: UICollectionView.SupplementaryRegistration<UICollectionViewCell>!
    
    let dataModel = [
        SymbolSection(title: "Weather", symbols: [
            SFSymbolItem(name: "sun.max.fill"),
            SFSymbolItem(name: "moon.fill"),
            SFSymbolItem(name: "sun.haze.fill"),
            SFSymbolItem(name: "moon.stars"),
            SFSymbolItem(name: "cloud.drizzle.fill"),
            SFSymbolItem(name: "cloud.snow"),
            SFSymbolItem(name: "tornado"),
            SFSymbolItem(name: "wind.snow"),
        ]),
        
        SymbolSection(title: "Health", symbols: [
            SFSymbolItem(name: "brain.head.profile"),
            SFSymbolItem(name: "heart.text.square.fill"),
            SFSymbolItem(name: "heart.circle"),
            SFSymbolItem(name: "cross.case"),
        ]),
        
        SymbolSection(title: "Connectivity", symbols: [
            SFSymbolItem(name: "personalhotspot.circle"),
            SFSymbolItem(name: "bolt.horizontal.circle.fill"),
            SFSymbolItem(name: "wifi.circle.fill"),
            SFSymbolItem(name: "antenna.radiowaves.left.and.right"),
            SFSymbolItem(name: "arrow.counterclockwise.icloud"),
            SFSymbolItem(name: "lock.icloud.fill"),
        ]),

    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        performCellRegistration()
        performHeaderRegistration()
        performFooterRegistration()
    }

}

private extension HeaderFooterViewController {
    
    private func configureCollectionView() {
        
        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let fraction: CGFloat = 1 / 4
            let inset: CGFloat = 2.5

            // Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(fraction),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(
                top: inset,
                leading: inset,
                bottom: inset,
                trailing: inset
            )

            // Group
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(fraction)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )

            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: inset,
                leading: inset,
                bottom: inset,
                trailing: inset
            )

            // Supplementary Item (Header)
            let headerItemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(50)
            )
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerItemSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )

            // Supplementary Item (Footer)
            let footerItemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(50)
            )
            let footerItem = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerItemSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
            
            section.boundarySupplementaryItems = [headerItem, footerItem]

            return section
        })
        
        // Create collection view with list layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        view = collectionView
    }
    
    private func performCellRegistration() {
        
        symbolCellRegistration = .init { cell, indexPath, item in

            cell.configurationUpdateHandler = { cell, state in
                cell.contentConfiguration = UIHostingConfiguration {
                    
                    Image(systemName: item.name)
                        .imageScale(.large)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color(.systemYellow))
                        }
                        .overlay {
                            // Show red border when cell is selected
                            RoundedRectangle(cornerRadius: 8.0)
                                .stroke(state.isSelected ? Color(.systemRed) : .clear, lineWidth: 4)
                        }
                }
            }
        }
    }
    
    private func performHeaderRegistration() {
        
        headerRegistration = .init(elementKind: UICollectionView.elementKindSectionHeader) { [unowned self]
            (header, elementKind, indexPath) in
            
            let symbolSection = dataModel[indexPath.section]

            header.contentConfiguration = UIHostingConfiguration {
                HeaderView(section: symbolSection)
            }
        }
    }
    
    private func performFooterRegistration() {
        
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter) { [unowned self]
            (footer, elementKind, indexPath) in
            
            let symbolSection = dataModel[indexPath.section]

            footer.contentConfiguration = UIHostingConfiguration {
                FooterView(section: symbolSection)
            }
        }
    }
}

extension HeaderFooterViewController: UICollectionViewDataSource {
    
    func numberOfSections(in: UICollectionView) -> Int {
        return dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let symbols = dataModel[section].symbols
        return symbols.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataModel[indexPath.section].symbols[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(
            using: symbolCellRegistration,
            for: indexPath,
            item: item
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath
            )
            return header
            
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueConfiguredReusableSupplementary(
                using: footerRegistration,
                for: indexPath
            )
            return footer
            
        default:
            fatalError("Unexpected element kind")
        }

    }
}

extension HeaderFooterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Remove all selection
        for symbolSection in dataModel {
            symbolSection.selectedCellIndex = nil
        }
        
        // Update selected cell index of the selected section
        let selectedSection = dataModel[indexPath.section]
        selectedSection.selectedCellIndex = indexPath.item
    }
}
