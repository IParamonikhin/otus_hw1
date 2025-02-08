//
//  CarListScreen.swift
//  otus_hw1
//
//  Created by Иван on 01.02.2025.
//

import SwiftUI

struct CarModel: Identifiable {
    let name: String
    var id: String { name }
}

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


struct CarListScreen: View {
    @EnvironmentObject var viewModel: CarListViewModel
    @Binding var selectedCar: String?

    var body: some View {
        ZStack {
            // Применяем серый фон ко всему экрану
            Color.gray
                .edgesIgnoringSafeArea(.all) // Это гарантирует, что фон покроет весь экран

            List {
                ForEach(viewModel.cars) { car in
                    NavigationLink(
                        destination: CarScreen(name: car.name),
                        tag: car.name,
                        selection: $selectedCar
                    ) {
                        HStack {
                            Image(car.name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .cornerRadius(5)
                            Text(car.name)
                                .font(.system(size: 25))
                        }
                        .background(Color.gray)
                    }
                    .listRowBackground(Color.gray)
                }
                .padding()
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Список машин")
        .onAppear {
            if let selectedCar = selectedCar {
                print("Selected car is \(selectedCar)")
            }
        }
    }
}

struct CarScreen: View {
    let name: String

    var body: some View {
            ZStack {
                Color.gray
                    .edgesIgnoringSafeArea(.all)
                
                Image(name)
                    .resizable()
                    .scaledToFit()
            }
            .navigationTitle(name)  // Устанавливаем заголовок
            .onAppear {
                print("Машина выбрана: \(name)")
            }
    }
}
