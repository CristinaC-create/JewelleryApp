//
//  TrackingDetailView.swift
//  Velora Jewellery
//
//  Created by Cristina Cabral on 2025-04-11.
//

import SwiftUI

struct TrackingDetailView: View {
    let order: JewelleryOrder
    @Environment(\.dismiss) var dismiss
    @State private var showLogoutAlert = false
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    Image(order.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 4)

                    Text(order.itemName)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.colorbackground)

                    VStack(spacing: 10) {
                        Text("Carrier: \(order.carrier)")
                        Text("Tracking #: \(order.trackingNumber)")
                        Text("Status: \(order.status)")
                            .foregroundColor(order.statusColor)
                    }
                    .font(.body)
                    .multilineTextAlignment(.center)

                    Button("Track Package") {
                        // Handle tracking
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.colorbackground)
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Tracking Info")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showProfile) {
                ProfileView(user: User(name: "Sophia Bennett", email: "sophia@example.com", profileImage: "profile_placeholder"))
            }
            .alert("Are you sure you want to log out?", isPresented: $showLogoutAlert) {
                Button("Log Out", role: .destructive) {
                    // Log out logic
                }
                Button("Cancel", role: .cancel) { }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.colorbackground)
                        .font(.system(size: 16, weight: .medium))
                    }
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
    TrackingDetailView(order: JewelleryOrder(
        id: 1,
        itemName: "Diamond Necklace",
        date: "Feb 10, 2024",
        price: "$1,200",
        status: "Shipped",
        image: "image1",
        carrier: "UPS",
        trackingNumber: "1Z1234567890"
    ))
}
