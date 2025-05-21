//
//  CheckoutView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-12.
//
import SwiftUI

struct CheckoutView: View {
    var cartItems: [CartItem]
    @Environment(\.dismiss) var dismiss

    @State private var selectedPaymentMethod: String = "Credit Card"
    @State private var shippingAddress: String = ""
    @State private var saveAddress: Bool = false
    @State private var showConfirmation = false
    @State private var showLogoutConfirm = false
    @State private var navigateToContentView = false

    var totalPrice: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: Text("Order Summary")) {
                        ForEach(cartItems) { item in
                            HStack {
                                Image(item.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text("$\(item.price, specifier: "%.2f") each")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }

                                Spacer()

                                Text("x\(item.quantity)")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                        }
                    }

                    Section(header: Text("Shipping Address")) {
                        TextField("Enter your address", text: $shippingAddress)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Toggle("Save this address for future orders", isOn: $saveAddress)
                    }

                    Section(header: Text("Payment Method")) {
                        Picker("Select Payment Method", selection: $selectedPaymentMethod) {
                            Text("Credit Card").tag("Credit Card")
                            Text("PayPal").tag("PayPal")
                            Text("Apple Pay").tag("Apple Pay")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    Section {
                        HStack {
                            Text("Total:")
                                .font(.headline)
                            Spacer()
                            Text("$\(totalPrice, specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(.colorbackground)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
                .padding(.horizontal)

                Button(action: {
                    if saveAddress {
                        UserDefaults.standard.set(shippingAddress, forKey: "savedShippingAddress")
                    }
                    showConfirmation.toggle()
                }) {
                    Text("Place Order")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.colorbackground.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .alert(isPresented: $showConfirmation) {
                    Alert(
                        title: Text("Order Placed!"),
                        message: Text("Thank you for your purchase. You will receive an email confirmation shortly."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 50)
            .background(
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
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

                ToolbarItem(placement: .principal) {
                    Text("Checkout")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.colorbackground)
                        .minimumScaleFactor(0.8)
                        .padding(.top, 8)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
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
                }
            }
            .onAppear {
                if let saved = UserDefaults.standard.string(forKey: "savedShippingAddress") {
                    shippingAddress = saved
                    saveAddress = true
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

// MARK: - Preview
struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(cartItems: [
            CartItem(name: "Ring", price: 99.99, quantity: 2, image: "image1"),
            CartItem(name: "Necklace", price: 149.99, quantity: 1, image: "image2"),
            CartItem(name: "Bracelet", price: 89.99, quantity: 1, image: "image3")
        ])
    }
}
