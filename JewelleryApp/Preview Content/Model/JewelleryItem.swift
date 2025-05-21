//
//  JewelleryItem.swift
//  Velora Jewellery
//
//  Created by Cristina Cabral on 2025-05-02.
//

import Foundation
import SwiftUI

struct JewelleryOrder: Identifiable {
    let id: Int
    let itemName: String
    let date: String
    let price: String
    let status: String
    let image: String
    let carrier: String
    let trackingNumber: String

    var statusColor: Color {
        switch status {
        case "Delivered": return .green
        case "Shipped": return .blue
        case "Processing": return .orange
        default: return .gray
        }
    }
}
