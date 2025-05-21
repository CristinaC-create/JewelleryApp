//
//  Cart.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-12.
//

import Foundation


class Cart: ObservableObject {
    @Published var items: [MyProduct] = []
    
    func addToCart(product: MyProduct) {
        items.append(product)
    }
    
    func removeFromCart(index: Int) {
        guard index >= 0, index < items.count else { return }
        items.remove(at: index)
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    func getTotalPrice() -> Double {
        return items.reduce(0) { $0 + $1.price }
    }
}
