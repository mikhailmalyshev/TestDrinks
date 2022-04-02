//
//  DrinksViewController.swift
//  TestDrinks
//
//  Created by Михаил Малышев on 01.04.2022.
//

import UIKit
import SnapKit

class DrinksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // Приватные свойства
    
    private var drinks: [Drink] = []
    private let url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
    
    // Конфигурация необходимых вью
    
    private lazy var collectionView: UICollectionView = {
        let layout = CollectionViewLeftAlignedLayout()
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
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Coctail name"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowOffset = CGSize(width: 5, height: 5)
        textField.layer.shadowRadius = 5.0
        textField.delegate = self
        return textField
    }()
    
    // Методы жизненного цикла ViewContoller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        NetworkManager.shared.fetchDrinksFrom(url) { result in
                self.drinks = result.drinks
                self.collectionView.reloadData()
        }
        hideKeyboardWhenTappedAroundTextField()
    }
    
    // Методы UICollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCollectionViewCell.reuseId, for: indexPath) as! DrinkCollectionViewCell
        
        let drink = drinks[indexPath.row]
        cell.label.text = drink.strDrink
        
        return cell
    }
    
    // Установка констреинтов
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
        }
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(500)
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
}

extension DrinksViewController: UITextFieldDelegate {
    
    // Выделение элементов при совпадении с текстом из searchTextField по клавише Return
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for i in 0..<drinks.count {
            guard let text = textField.text else { return false }
            if drinks[i].strDrink.contains(text) {
                let indexPath = IndexPath(item: i, section: 0)
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            } else {
                let indexPath = IndexPath(item: i, section: 0)
                collectionView.deselectItem(at: indexPath, animated: true)
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    // Скрытие клавиатуры по тапу вне searchTextField
    
    func hideKeyboardWhenTappedAroundTextField() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

