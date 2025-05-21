//
//  CartItem.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-21.
//
import Foundation


struct CartItem: Identifiable {
    var id: UUID = UUID() // ✅ not let
        var name: String
        var price: Double
        var quantity: Int
        var image: String
    }
