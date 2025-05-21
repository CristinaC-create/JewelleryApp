//
//  JewelleryAppApp.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-05.
//

import SwiftUI

@main
struct JewelleryAppApp: App {
    @StateObject private var cartManager = CartManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cartManager)
        }
    }
}
