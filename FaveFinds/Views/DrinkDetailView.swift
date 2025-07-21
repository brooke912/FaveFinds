//
//  DrinkDetailView.swift
//  FaveFinds
//
//  Created by Brooke Gates on 7/20/25.
//

import SwiftUI

struct DrinkDetailView: View {
    var drink: Drink

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let imageUrl = drink.strDrinkThumb, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                    } placeholder: {
                        ProgressView()
                    }
                }

                Text(drink.strDrink)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)

                if let instructions = drink.strInstructions {
                    Text("Instructions")
                        .font(.headline)
                        .padding(.top)

                    Text(instructions)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("🍸 Details")
    }
}
