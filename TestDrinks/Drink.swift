//
//  Drink.swift
//  TestDrinks
//
//  Created by Михаил Малышев on 01.04.2022.
//

struct Result: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink : String
    var isTaped : Bool? = false
}
