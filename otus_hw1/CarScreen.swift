//
//  CarScreen.swift
//  otus_hw1
//
//  Created by Иван on 01.02.2025.
//
import SwiftUI

struct CarScreen: View {
    let name: String
    
    var body: some View {
        HStack{
            Image(name)
                .resizable()
                .scaledToFit()
        }
        .navigationTitle(name)
    }
}
