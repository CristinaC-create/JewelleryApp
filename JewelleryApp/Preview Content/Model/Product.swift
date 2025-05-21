//
//  Product.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-06.
//

import Foundation

struct MyProduct: Identifiable, Hashable {
    let id: UUID = UUID() // ✅ must be stable and unique
    let name: String
    let price: Double
    let description: String
    let imageName: String
    let category: String
    let originalPrice: Double
    let discountPercentage: Int?

    static func == (lhs: MyProduct, rhs: MyProduct) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
