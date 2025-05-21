//
//  OrderView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-12.
//

import Foundation


struct Order: Identifiable {
    let id: String
    let userId: String
    let items: [MyProduct] 
    let totalAmount: Double
    let timestamp: Date
    let status: OrderStatus
}

enum OrderStatus: String, Codable {
    case pending, shipped, delivered, canceled
}
