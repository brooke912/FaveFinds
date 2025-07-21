//
//  Drink.swift
//  FaveFinds
//
//  Created by Brooke Gates on 7/20/25.
//

import Foundation

struct DrinkResponse: Codable {
    let drinks: [Drink]
}

struct Drink: Codable, Identifiable {
    let idDrink: String
    let strDrink: String
    let strCategory: String?
    let strInstructions: String?
    let strDrinkThumb: String?

    var id: String { idDrink }
}
