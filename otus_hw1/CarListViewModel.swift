//
//  CarListViewModel.swift
//  otus_hw1
//
//  Created by Иван on 02.02.2025.
//

import SwiftUI

final class CarListViewModel: ObservableObject {
    
    @Published var cars: [CarModel] = [
        CarModel(name: "Audi"),
        CarModel(name: "BMW"),
        CarModel(name: "Dodge"),
        CarModel(name: "Ford"),
        CarModel(name: "Lamborghini"),
        CarModel(name: "Mercedes")
    ]
}
