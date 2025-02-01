//
//  CarModel.swift
//  otus_hw1
//
//  Created by Иван on 02.02.2025.
//


struct CarModel: Identifiable {
    let name: String
    var id: String { name }
}
