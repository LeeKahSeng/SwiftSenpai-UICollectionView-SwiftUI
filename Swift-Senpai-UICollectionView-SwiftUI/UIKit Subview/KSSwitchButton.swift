//
//  KSSwitchButton.swift
//  Swift-Senpai-UICollectionView-SwiftUI
//
//  Created by Kah Seng Lee on 08/04/2023.
//

import UIKit

class KSSwitchButton: UIButton {
    
    var switchButtonValueDidChanged: ((_ switchButton: KSSwitchButton, _ isSelected: Bool) -> Void)?
    
    @IBInspectable
    var onImage: UIImage? {
        didSet {
            setButton(image: onImage, for: .selected)
        }
    }
    
    @IBInspectable
    var offImage: UIImage? {
        didSet {
            setButton(image: offImage, for: .normal)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
}

// MARK: - Public functions
extension KSSwitchButton {
    
    func toggle() {
        self.isSelected.toggle()
    }
}

// MARK: - Private functions
private extension KSSwitchButton {
    
    func commonSetup() {
        
        precondition(buttonType == .custom, "Button type must be 'custom'")

        setButton(image: offImage, for: .normal)
        setButton(image: onImage, for: .selected)
        
        // Override touch up inside event
        addTarget(self, action: #selector(touchUpInside(sender:)), for: .touchUpInside)
    }
    
    func setButton(image: UIImage?, for state: UIControl.State) {
        guard let image else {
            return
        }
        
        self.setImage(image, for: state)
    }
    
    @objc func touchUpInside(sender: KSSwitchButton) {
        self.isSelected.toggle()
        switchButtonValueDidChanged?(self, self.isSelected)
    }
}
