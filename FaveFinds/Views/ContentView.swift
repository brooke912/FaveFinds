//
//  ContentView.swift
//  FaveFinds
//
//  Created by Brooke Gates on 7/20/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = DrinkViewModel()
    @State private var searchText: String = ""
    @State private var selectedFilter: String = "All"
    let filterOptions = ["All", "Cocktail", "Ordinary Drink", "Soft Drink"]

    var body: some View {
        NavigationStack {
            ZStack {
                // background
                Color(red: 1.0, green: 0.94, blue: 0.96)
                    .ignoresSafeArea()

                VStack(spacing: 12) {
                    // Search bar
                    HStack {
                        TextField("Search drinks...", text: $searchText)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(8)
                            .submitLabel(.search)
                            .onSubmit {
                                viewModel.fetchDrinks(searchQuery: searchText)
                            }

                        Button(action: {
                            viewModel.fetchDrinks(searchQuery: searchText)
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.pink)
                        }
                    }
                    .padding(.horizontal)

                    // Filters
                    Picker("Filter", selection: $selectedFilter) {
                        ForEach(filterOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .onChange(of: selectedFilter) {
                        viewModel.applyFilter(selectedFilter)
                    }

                    // Drink list
                    List(viewModel.drinks) { drink in
                        NavigationLink(destination: DrinkDetailView(drink: drink)) {
                            HStack {
                                AsyncImage(url: URL(string: drink.strDrinkThumb ?? "")) { image in
                                    image.resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.pink.opacity(0.3)
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                                VStack(alignment: .leading) {
                                    Text(drink.strDrink)
                                        .font(.headline)
                                    Text(drink.strCategory ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }
            }
            .navigationTitle("FaveFinds 🍸")
            .onAppear {
                viewModel.fetchDrinks(searchQuery: "margarita")
            }
        }
    }
}
