//
//  DrinkCollectionViewCell.swift
//  TestDrinks
//
//  Created by Михаил Малышев on 01.04.2022.
//

import UIKit
import SnapKit

// MARK: CustomViewCell

class DrinkCollectionViewCell: UICollectionViewCell {
    
    // Идентификатор ячейки
    
    static let reuseId = "drinkCell"
    
    // Конфигурация необходимых вью
    
    lazy var label: UILabel = {
        var label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .lightGray
        return view
    }()
    
    // Создание градиента
    
    private lazy var gradient: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 5
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Установка констреинтов
    
    private func setupLayout() {
        cardView.addSubview(label)
        addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    // Если ячейка выбрана, то закрашиваем градиентом
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                cardView.layer.insertSublayer(gradient, at: 0)
            } else {
                gradient.removeFromSuperlayer()
            }
        }
    }
}

