//
//  MainScreen.swift
//  otus_hw1
//
//  Created by Иван on 01.02.2025.
//

import SwiftUI

enum Tabs: Hashable {
    case main, carList
}

struct MainScreen: View {
    @State private var selectionTab: Tabs = .main
    @State private var selectedCar: String? = nil
    @ObservedObject var viewModel: CarListViewModel = .init()

    var body: some View {
        NavigationView {
            TabView(selection: $selectionTab) {
                MainTabView(selectionTab: $selectionTab, selectedCar: $selectedCar)
                    .tag(Tabs.main)
                    .tabItem {
                        Label("Main", systemImage: "house")
                    }

                CarListScreen(selectedCar: $selectedCar)
                    .tag(Tabs.carList)
                    .tabItem {
                        Label("Car List", systemImage: "car")
                    }
            }
            .background(Color.gray)
            .environmentObject(viewModel)
            .onChange(of: selectedCar) { newCar in
                if selectedCar != nil {
                    selectionTab = .carList
                }
            }
        }
        .accentColor(.orange)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainTabView: View {
    @Binding var selectionTab: Tabs
    @Binding var selectedCar: String?
    @EnvironmentObject var viewModel: CarListViewModel

    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.cars) { car in
                        VStack {
                            Button(action: {
                                selectedCar = car.name
                                selectionTab = .carList
                                print("Selected car: \(car.name)")
                            }) {
                                Image(car.name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4)  // Пропорциональный размер изображения
                                    .clipped()
                                    .cornerRadius(10)
                                    .shadow(color: .black, radius: 10)
                            }
                            .buttonStyle(PlainButtonStyle())

                            Text(car.name)
                                .font(.system(size: 30))
                                .frame(maxWidth: .infinity)  // Ограничиваем ширину текста
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8)  // Пропорциональная ширина всей карточки
                    }
                }
                .padding(16)
            }
        }
    }
}

#Preview {
    MainScreen()
}
