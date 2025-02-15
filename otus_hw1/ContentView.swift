//
//  MainScreen.swift
//  otus_hw1
//
//  Created by Иван on 01.02.2025.
//

import SwiftUI

enum Tabs: Hashable {
    case main, carList, modal
}

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

struct UILabelWrapper: UIViewRepresentable {
    let text: String

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
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

                ModalTabView()
                    .tag(Tabs.modal)
                    .tabItem {
                        Label("Modal Car Screen", systemImage: "plus.app")
                    }
            }
            .background(Color.gray)
            .environmentObject(viewModel)
            .onChange(of: selectedCar) { newCar in
                if newCar != nil {
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
                                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4)
                                    .clipped()
                                    .cornerRadius(10)
                                    .shadow(color: .black, radius: 10)
                            }
                            .buttonStyle(PlainButtonStyle())

                            Text(car.name)
                                .font(.system(size: 30))
                                .frame(maxWidth: .infinity)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                    }
                }
                .padding(16)
            }
        }
    }
}


struct CarListScreen: View {
    @EnvironmentObject var viewModel: CarListViewModel
    @Binding var selectedCar: String?

    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)

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
                            
                            UILabelWrapper(text: car.name)
                                .frame(height: 30)
                        }
                        .frame(height: 70)
                    }
                    .listRowBackground(Color.gray)
                }
                .padding(.bottom, 10)
            }
            .listStyle(PlainListStyle())
            .padding(.bottom, 10)
        }
        .navigationTitle("Список машин")
        .padding(.bottom, 10)
    }
}

struct ModalTabView: View {
    @State private var modalSelectedCar: String? = nil
    @State private var isShowModal: Bool = false
    @EnvironmentObject var viewModel: CarListViewModel

    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.cars) { car in
                        VStack {
                            Button(action: { modalSelectedCar = car.name }) {
                                Image(car.name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4)
                                    .clipped()
                                    .cornerRadius(10)
                                    .shadow(color: .black, radius: 10)
                            }
                            .buttonStyle(PlainButtonStyle())
                            Text(car.name)
                                .font(.system(size: 30))
                                .frame(maxWidth: .infinity)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                    }
                }
                .padding(16)
            }
        }
        .onChange(of: modalSelectedCar) { newCar in
            isShowModal = newCar != nil
        }
        .sheet(isPresented: $isShowModal, onDismiss: { modalSelectedCar = nil }) {
            if let carName = modalSelectedCar {
                CarScreen(name: carName)
                    .navigationBarBackButtonHidden(true)
            } else {
                Text("Ошибка: машина не выбрана")
                    .font(.title)
                    .foregroundColor(.red)
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
            .navigationTitle(name)
            .onAppear {
                print("Машина выбрана: \(name)")
            }
    }
}

#Preview {
    MainScreen()
}
