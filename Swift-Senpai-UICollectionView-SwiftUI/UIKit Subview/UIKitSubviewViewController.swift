//
//  UIKitSubviewViewController.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 08/04/2023.
//

import UIKit
import SwiftUI

class UIKitSubviewViewController: UIViewController {
    
    @IBOutlet weak var checkbox: KSSwitchButton!
    @IBOutlet weak var textContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure checkbox
        checkbox.onImage = UIImage(systemName: "checkmark.square")
        checkbox.offImage = UIImage(systemName: "square")
        
        // Configure `agreementView`
        let agreementView = AgreementView()
        checkbox.switchButtonValueDidChanged = { (_, isSelected) in
            agreementView.setIsChecked(isSelected)
        }

        // Convert `agreementView` to UIView
        let config = UIHostingConfiguration {
            agreementView
        }
        let subview = config.makeContentView()
        
        // Add `agreementView` into a container view
        textContainerView.addSubview(subview)
        textContainerView.translatesAutoresizingMaskIntoConstraints = false
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textContainerView.topAnchor.constraint(equalTo: subview.topAnchor),
            textContainerView.bottomAnchor.constraint(equalTo: subview.bottomAnchor),
            textContainerView.leadingAnchor.constraint(equalTo: subview.leadingAnchor),
            textContainerView.trailingAnchor.constraint(equalTo: subview.trailingAnchor),
        ])
    }
}
