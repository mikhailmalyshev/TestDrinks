//
//  Drink.swift
//  TestDrinks
//
//  Created by Михаил Малышев on 01.04.2022.
//

// MARK: Model

struct Result: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink : String
}
