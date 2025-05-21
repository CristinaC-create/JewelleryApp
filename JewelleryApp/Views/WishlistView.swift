//
//  WishlistView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-21.
//

import SwiftUI

struct WishlistView: View {
    @State private var wishlistItems: [WishlistItem] = [
        WishlistItem(id: 1, name: "Diamond Necklace", price: "$1,200", image: "image2"),
        WishlistItem(id: 2, name: "Gold Bracelet", price: "$800", image: "image1"),
        WishlistItem(id: 3, name: "Sapphire Ring", price: "$950", image: "image2"),
        WishlistItem(id: 4, name: "Sapphire Ring", price: "$950", image: "image3"),
        WishlistItem(id: 5, name: "Sapphire Ring", price: "$950", image: "image4"),
        WishlistItem(id: 6, name: "Sapphire Ring", price: "$950", image: "image5")
    ]

    @State private var showLogoutAlert = false
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()

                VStack {
                    Spacer().frame(height: 30)

                    if wishlistItems.isEmpty {
                        Spacer()
                        VStack(spacing: 20) {
                            Image(systemName: "heart.slash.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.colorbackground)

                            Text("Your wishlist is empty.")
                                .font(.headline)
                                .foregroundColor(.colorbackground)
                        }
                        .padding()
                    } else {
                        List {
                            ForEach(wishlistItems) { item in
                                HStack {
                                    Image(item.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(radius: 2)

                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.price)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.leading, 8)

                                    Spacer()

                                    Button(action: {
                                        removeItem(item)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.colorbackground)
                                            .padding(10)
                                            .background(Color.colorbackground.opacity(0.2))
                                            .clipShape(Circle())
                                    }
                                }
                                .padding(.vertical, 5)
                            }
                        }
                        .listStyle(.plain)
                    }

                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showProfile) {
                ProfileView(user: User(name: "Sophia Bennett", email: "sophia@example.com", profileImage: "profile_placeholder"))
            }
            .alert("Are you sure you want to log out?", isPresented: $showLogoutAlert) {
                Button("Log Out", role: .destructive) {
                    // Logout logic
                }
                Button("Cancel", role: .cancel) { }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Wishlist")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.colorbackground)
                        .minimumScaleFactor(0.8)
                        .padding(.top, 8)
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

    private func removeItem(_ item: WishlistItem) {
        wishlistItems.removeAll { $0.id == item.id }
    }
}

// MARK: - Preview
struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView()
    }
}
