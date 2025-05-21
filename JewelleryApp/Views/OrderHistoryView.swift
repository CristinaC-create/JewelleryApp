//
//  OrderHistoryView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-12.
//
import SwiftUI


struct OrderHistoryView: View {
    @State private var orders: [JewelleryOrder] = [
        JewelleryOrder(id: 1, itemName: "Diamond Necklace", date: "Feb 10, 2024", price: "$1,200", status: "Delivered", image: "image1", carrier: "UPS", trackingNumber: "1Z12345678"),
        JewelleryOrder(id: 2, itemName: "Gold Bracelet", date: "Jan 25, 2024", price: "$800", status: "Shipped", image: "image4", carrier: "FedEx", trackingNumber: "FEDEX123456"),
        JewelleryOrder(id: 3, itemName: "Sapphire Ring", date: "Jan 10, 2024", price: "$950", status: "Processing", image: "image3", carrier: "DHL", trackingNumber: "DHL78910")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Image("order_banner")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 4)
                        .padding(.top, 0)

                    if orders.isEmpty {
                        VStack(spacing: 10) {
                            Image(systemName: "cart.badge.questionmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)

                            Text("No orders yet")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    } else {
                        VStack(spacing: 16) {
                            ForEach(orders) { order in
                                NavigationLink(destination: TrackingDetailView(order: order)) {
                                    OrderRow(order: order)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.85))
                        .cornerRadius(15)
                        .shadow(radius: 4)
                        .frame(maxWidth: 500)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
            }
            .background(
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 8)
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Order History")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.colorbackground)
                        .padding(.top, 50)
                }
            }
        }
    }
}

struct OrderRow: View {
    let order: JewelleryOrder

    var body: some View {
        HStack(spacing: 16) {
            Image(order.image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 2)

            VStack(alignment: .leading, spacing: 4) {
                Text(order.itemName)
                    .font(.headline)
                Text(order.date)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(order.price)
                    .font(.headline)
                Text(order.status)
                    .font(.subheadline)
                    .foregroundColor(order.statusColor)
            }
        }
        .padding()
        .background(Color.white.opacity(0.85))
        .cornerRadius(12)
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
    }
}
