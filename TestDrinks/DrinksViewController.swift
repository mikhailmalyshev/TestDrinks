//
//  DrinksViewController.swift
//  TestDrinks
//
//  Created by Михаил Малышев on 01.04.2022.
//

import UIKit
import SnapKit

class DrinksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var drinks: [Drink] = []
    private let url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLeftAlignedLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DrinkCollectionViewCell.self, forCellWithReuseIdentifier: DrinkCollectionViewCell.reuseId)
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        setupConstraints()
        NetworkManager.shared.fetchDrinksFrom(url) { result in
                self.drinks = result.drinks
                self.collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCollectionViewCell.reuseId, for: indexPath) as! DrinkCollectionViewCell
        
        let drink = drinks[indexPath.row]
        
        cell.button.setTitle(drink.strDrink, for: .normal)
        cell.button.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCollectionViewCell.reuseId, for: indexPath) as! DrinkCollectionViewCell
////
////
////        var drink = drinks[indexPath.item]
////        if drink.isTaped! {
////            drink.isTaped = false
////        } else {
////            drink.isTaped = true
////            cell.button.backgroundColor = .red
////        }
//    }
    
    @objc func tapOnButton() {
        
    }
    
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}

