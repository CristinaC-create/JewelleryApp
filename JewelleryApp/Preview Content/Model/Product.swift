//
//  Product.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-06.
//

import Foundation
import SwiftUI
import SwiftData


struct MyProduct: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let description: String
    let imageName: String
    let category: String
    let originalPrice: Double
    let discountPercentage: Int?
}
