//
//  ShippedView.swift
//  Velora Jewellery
//
//  Created by Cristina Cabral on 2025-04-11.
//

import SwiftUI

struct ShippedView: View {
    @Binding var isPresented: Bool
    @State private var showLogoutAlert = false
    @State private var showProfile = false

    @State private var shippedOrders: [JewelleryOrder] = [
        JewelleryOrder(id: 1, itemName: "Diamond Necklace", date: "Feb 10, 2024", price: "$1,200", status: "Shipped", image: "image1", carrier: "UPS", trackingNumber: "1Z12345"),
        JewelleryOrder(id: 2, itemName: "Gold Bracelet", date: "Jan 25, 2024", price: "$800", status: "Shipped", image: "image4", carrier: "FedEx", trackingNumber: "1234567890")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        Text("Your Items Have Shipped")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.colorbackground)
                            .multilineTextAlignment(.center)
                            .padding(.top, 40)

                        if shippedOrders.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "shippingbox")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.gray)

                                Text("No shipped items yet.")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        } else {
                            VStack(spacing: 16) {
                                ForEach(shippedOrders) { order in
                                    NavigationLink(destination: TrackingDetailView(order: order)) {
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
                                                Text("Carrier: \(order.carrier)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }

                                            Spacer()

                                            Text(order.status)
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.colorbackground)
                                        }
                                        .padding()
                                        .background(Color.white.opacity(0.9))
                                        .cornerRadius(12)
                                        .shadow(radius: 3)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .frame(maxWidth: 380)
                            .padding(.horizontal, 20)
                        }

                        Spacer(minLength: 40)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showProfile) {
                ProfileView(user: User(name: "Sophia Bennett", email: "sophia@example.com", profileImage: "profile_placeholder"))
            }
            .alert("Are you sure you want to log out?", isPresented: $showLogoutAlert) {
                Button("Log Out", role: .destructive) {
                    isPresented = false
                }
                Button("Cancel", role: .cancel) { }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.colorbackground)
                        .font(.system(size: 16, weight: .medium))
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("Shipment Status")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.colorbackground)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Profile") {
                            showProfile = true
                        }
                        Button("Log Out", role: .destructive) {
                            showLogoutAlert = true
                        }
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.colorbackground)
                    }
                }
            }
        }
    }
}

#Preview {
    ShippedView(isPresented: .constant(true))
}
