//
//  CartView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-12.
//
// CartView.swift


import SwiftUI

struct CartView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartManager: CartManager
    @State private var showLogoutConfirm = false
    @State private var navigateToContentView = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()

                VStack {
                    if cartManager.items.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "cart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.colorbackground)

                            Text("Your cart is empty")
                                .font(.headline)
                                .foregroundColor(.colorbackground)
                        }
                        .padding()
                    } else {
                        List {
                            ForEach($cartManager.items) { $item in
                                HStack {
                                    if UIImage(named: item.image) != nil {
                                        Image(item.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.gray)
                                    }

                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text("$\(item.price, specifier: "%.2f") each")
                                            .font(.subheadline)
                                            .foregroundColor(.colorbackground)
                                    }

                                    Spacer()

                                    HStack {
                                        Button {
                                            if item.quantity > 1 {
                                                item.quantity -= 1
                                            }
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                        }

                                        Text("\(item.quantity)")
                                            .font(.headline)
                                            .frame(width: 30)

                                        Button {
                                            item.quantity += 1
                                        } label: {
                                            Image(systemName: "plus.circle.fill")
                                                .foregroundColor(.green)
                                        }
                                    }
                                }
                                .padding(.vertical, 5)
                            }
                            .onDelete { indexSet in
                                cartManager.remove(at: indexSet)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)

                        HStack {
                            Text("Total:")
                                .font(.headline)
                            Spacer()
                            Text("$\(cartManager.totalPrice, specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(.colorbackground)
                        }
                        .padding()

                        NavigationLink(destination: CheckoutView(cartItems: cartManager.items)) {
                            Text("Proceed to Checkout")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.colorbackground.opacity(0.7))
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.colorbackground)
                        .font(.system(size: 16, weight: .medium))
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Your Cart")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.colorbackground)
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        NavigationLink(destination: ProfileView(user: User(name: "Sophia Bennett", email: "sophia@example.com", profileImage: "profile_placeholder"))) {
                            Label("Profile", systemImage: "person.circle")
                        }

                        Button(role: .destructive) {
                            showLogoutConfirm = true
                        } label: {
                            Label("Log Out", systemImage: "arrow.backward.square")
                        }
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.colorbackground)
                    }

                    EditButton()
                        .foregroundColor(.colorbackground)
                }
            }
            .navigationDestination(isPresented: $navigateToContentView) {
                ContentView()
            }
            .alert("Are you sure you want to log out?", isPresented: $showLogoutConfirm) {
                Button("Cancel", role: .cancel) {}
                Button("Log Out", role: .destructive) {
                    navigateToContentView = true
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
