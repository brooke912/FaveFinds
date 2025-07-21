//
//  DrinkViewModel.swift
//  FaveFinds
//
//  Created by Brooke Gates on 7/20/25.
//

import Foundation

class DrinkViewModel: ObservableObject {
    @Published var allDrinks: [Drink] = []        // full unfiltered list
    @Published var drinks: [Drink] = []           // filtered list

    func fetchDrinks(searchQuery: String) {
        let query = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "margarita"
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(query)") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(DrinkResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.allDrinks = decoded.drinks
                        self.drinks = decoded.drinks
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else {
                print("API request failed:", error?.localizedDescription ?? "Unknown error")
            }
        }.resume()
    }

    func applyFilter(_ type: String) {
        if type == "All" {
            drinks = allDrinks
        } else {
            drinks = allDrinks.filter { $0.strCategory?.localizedCaseInsensitiveContains(type) == true }
        }
    }
}
