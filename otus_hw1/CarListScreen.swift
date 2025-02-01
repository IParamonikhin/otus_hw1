//
//  CarListScreen.swift
//  otus_hw1
//
//  Created by Иван on 01.02.2025.
//

import SwiftUI


struct CarListScreen: View {
    @ObservedObject var viewModel: CarListViewModel = .init()
    var body: some View {
        List {
            ForEach(viewModel.cars) { car in
                //Button {
                NavigationLink(destination: CarScreen(name: car.name)){
                    HStack { Image(car.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                            .cornerRadius(5)
                        Text(car.name)
                            .font(.system(size: 25))
                    }
                }
                //}
            }
        }
    }
}
