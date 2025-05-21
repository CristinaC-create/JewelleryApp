//
//  CartManager.swift
//  Velora Jewellery
//
//  Created by Cristina Cabral on 2025-04-25.
//

import Foundation

final class CartManager: ObservableObject {
    @Published var items: [CartItem] = []

    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

    func add(product: MyProduct) {
        if let index = items.firstIndex(where: { $0.name == product.name }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(
                id: UUID(),
                name: product.name,
                price: product.price,
                quantity: 1,
                image: product.imageName
            ))
        }
    }

    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func increaseQuantity(for item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
        }
    }

    func decreaseQuantity(for item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }), items[index].quantity > 1 {
            items[index].quantity -= 1
        }
    }
}
