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
    @State var selectionTab: Tabs = .main
    @ObservedObject var viewModel: CarListViewModel = .init()
    var body: some View {
        NavigationView{
            TabView(selection: $selectionTab) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.cars) { car in
                            VStack{
                                Image(car.name)
                                    .resizable()
                                    .frame(width: 250, height: 350)
                                    .cornerRadius(10)
                                    .shadow(color: .black, radius: 10)
                                Text(car.name).font(.system(size: 30))
                            }
                        }
                        .padding(8)
                    }
                    .padding(8)
                }
                .tag(Tabs.main)
                .tabItem {
                    Label("Main", systemImage: "house")
                }
                CarListScreen()
                    .tag(Tabs.carList)
                    .tabItem {
                        Label("Car List", systemImage: "car")
                    }
            }
            .accentColor(.orange)
        }
    }
}

#Preview {
    MainScreen()
}
