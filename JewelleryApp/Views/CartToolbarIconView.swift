//
//  CartToolbarIconView.swift
//  Velora Jewellery
//
//  Created by Cristina Cabral on 2025-04-25.
//

import SwiftUI


struct CartToolbarIcon: View {
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        NavigationLink(destination: CartView()) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.colorbackground)

                if cartManager.items.count > 0 {
                    Text("\(cartManager.items.count)")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 10, y: -10)
                }
            }
        }
    }
}
