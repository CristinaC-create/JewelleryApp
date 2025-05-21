//
//  ProductDetailView.swift
//  Velora Jewellery
//
//  Created by Cristina Cabral on 2025-04-11.
//

// ProductDetailView.swift

import SwiftUI

struct ProductDetailView: View {
    let product: MyProduct
    var isSale: Bool = false
    @EnvironmentObject var cartManager: CartManager

    @State private var selectedRelatedProduct: MyProduct? = nil
    @State private var navigateToProfile = false
    @State private var navigateToContentView = false

    let relatedProducts: [MyProduct] = [
        MyProduct(name: "Silver Ring", price: 120.0, description: "Simple and elegant silver ring.", imageName: "image5", category: "Rings", originalPrice: 150.0, discountPercentage: 20),
        MyProduct(name: "Pearl Earrings", price: 220.0, description: "Classy pearl earrings for any occasion.", imageName: "image3", category: "Earrings", originalPrice: 300.0, discountPercentage: 25),
        MyProduct(name: "Gold Bracelet", price: 180.0, description: "Luxury gold bracelet.", imageName: "image4", category: "Bracelets", originalPrice: 250.0, discountPercentage: 30)
    ]

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    Image(product.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))

                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    VStack(spacing: 6) {
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)

                        if isSale, let discount = product.discountPercentage {
                            HStack(spacing: 6) {
                                Text("$\(product.originalPrice, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .strikethrough()

                                Text("\(discount)% off")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                                    .fontWeight(.medium)
                            }
                        }
                    }

                    Button(action: {
                        cartManager.add(product: product)
                    }) {
                        Text("Add to Cart")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.colorbackground)
                            .opacity(0.7)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal, 20)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("You Might Also Like")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .foregroundColor(.colorbackground)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(relatedProducts) { relatedProduct in
                                    Button(action: {
                                        selectedRelatedProduct = relatedProduct
                                    }) {
                                        VStack(alignment: .leading, spacing: 6) {
                                            Image(relatedProduct.imageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 120, height: 120)
                                                .cornerRadius(10)

                                            Text(relatedProduct.name)
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                                .lineLimit(1)

                                            Text("$\(relatedProduct.price, specifier: "%.2f")")
                                                .font(.footnote)
                                                .foregroundColor(.primary)

                                            if let discount = relatedProduct.discountPercentage {
                                                Text("\(discount)% off")
                                                    .font(.caption)
                                                    .foregroundColor(.red)
                                                    .fontWeight(.medium)
                                            }
                                        }
                                        .padding()
                                        .background(Color.white.opacity(0.9))
                                        .cornerRadius(12)
                                        .shadow(radius: 2)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 30)
                }
                .padding(.top, 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView()
            }

            ToolbarItem(placement: .principal) {
                Text(product.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.colorbackground)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Menu {
                        Button("Profile") {
                            navigateToProfile = true
                        }
                        Button("Logout", role: .destructive) {
                            navigateToContentView = true
                        }
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.colorbackground)
                    }

                    CartToolbarIcon() // assumes this routes correctly to CartView
                }
            }
        }
        .navigationDestination(item: $selectedRelatedProduct) { relatedProduct in
            ProductDetailView(product: relatedProduct, isSale: relatedProduct.discountPercentage != nil)
                .environmentObject(cartManager)
        }
        .navigationDestination(isPresented: $navigateToProfile) {
            ProfileView(user: User(name: "Sophia Bennett", email: "sophia@example.com", profileImage: "profile_placeholder"))
        }
        .navigationDestination(isPresented: $navigateToContentView) {
            ContentView()
        }
    }
}

struct BackButtonView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
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
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductDetailView(
                product: MyProduct(
                    name: "Diamond Necklace",
                    price: 1200.0,
                    description: "A beautiful handcrafted necklace with shimmering diamonds.",
                    imageName: "image1",
                    category: "Necklaces",
                    originalPrice: 1500.0,
                    discountPercentage: 20
                )
            )
            .environmentObject(CartManager())
        }
    }
}
