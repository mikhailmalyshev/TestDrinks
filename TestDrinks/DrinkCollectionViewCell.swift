//
//  DrinkCollectionViewCell.swift
//  TestDrinks
//
//  Created by Михаил Малышев on 01.04.2022.
//

import UIKit
import SnapKit

class DrinkCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "drinkCell"
    
//    lazy var label: UILabel = {
//       var label = UILabel()
//        label.backgroundColor = .lightGray
//        return label
//    }()
    
    var bool = false
    
    lazy var button: UIButton = {
        var button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .lightGray
        button.configuration = config
        button.layer.cornerRadius = 10

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
//    @objc func tapOnButton(item: Bool) {
//        if item {
//            button.backgroundColor = .red
//        } else {
//            button.backgroundColor = .lightGray
//        }
//    }
}
