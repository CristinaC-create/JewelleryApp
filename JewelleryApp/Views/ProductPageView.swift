//
//  ProductPageView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-06.
//


// ProductPageView.swift
import SwiftUI

struct ProductPageView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var navigateToContentView = false
    @State private var showLogoutConfirm = false

    let products: [MyProduct] = [
        MyProduct(name: "Moonlit Charm Anklet", price: 75.00, description: "A delicate anklet adorned with celestial charms — made to shimmer under moonlight and barefoot skies", imageName: "image1", category: "Anklets", originalPrice: 30.0, discountPercentage: nil),
        MyProduct(name: "Halo Gypsy Head Piece", price: 100.00, description: "A radiant crown for free spirits — woven with celestial charm and wanderer’s grace", imageName: "image2", category: "Head Pieces", originalPrice: 40.0, discountPercentage: nil),
        MyProduct(name: "Moonveil Pendant Necklace", price: 65.00, description: "A dreamy, hand-finished piece inspired by moonlight and boho charm — perfect for layering or wearing solo", imageName: "image3", category: "Necklaces", originalPrice: 25.0, discountPercentage: nil),
        MyProduct(name: "Starfall Drop Earrings", price: 85.00, description: "Bold, celestial-inspired drops that shimmer with every move — made to channel your inner stargazer", imageName: "image4", category: "Earrings", originalPrice: 20.0, discountPercentage: nil),
        MyProduct(name: "SpiritStone Ring", price: 50.00, description: "An earthy statement ring that shifts with your energy — grounded in soul, glowing with mood", imageName: "image5", category: "Rings", originalPrice: 15.0, discountPercentage: nil),
        MyProduct(name: "Boheme Wrap Choker", price: 95.00, description: "A close-fitting necklace woven with free-spirited charm — perfect for layering or making a bold, boho statement", imageName: "image7", category: "Neckband", originalPrice: 15.0, discountPercentage: nil),
        MyProduct(name: "Bohemia Bracelet Set", price: 120.00, description: "An earthy wrap that hugs the arm with quiet strength — woven for wanderers, grounded in spirit", imageName: "image8", category: "Bracelets", originalPrice: 15.0, discountPercentage: nil),
    
    ]

    let saleItems: [MyProduct] = [
        MyProduct(name: "Bohemia Bracelet Set", price: 100.00, description: "An earthy wrap that hugs the arm with quiet strength — woven for wanderers, grounded in spirit", imageName: "image8", category: "Bracelets", originalPrice: 120.00, discountPercentage: 15),
        MyProduct(name: "SpiritStone Ring", price: 100.00, description:"An earthy statement ring that shifts with your energy — grounded in soul, glowing with mood", imageName: "image5", category: "Rings", originalPrice: 50.00, discountPercentage: 15),
        MyProduct(name: "Celestial Headress", price: 150.00, description: "A boho headress featuring a delicate veil adorned with silver charms.", imageName: "image6", category: "Necklaces", originalPrice: 90.0, discountPercentage: 30),
        MyProduct(name: "Starfall Drop Earrings", price: 85.00, description: "Bold, celestial-inspired drops that shimmer with every move — made to channel your inner stargazer", imageName: "image4", category: "Earrings", originalPrice: 20.00, discountPercentage: 15),
        MyProduct(name:  "Boheme Wrap Choker", price: 120.00, description: "A close-fitting necklace woven with free-spirited charm — perfect for layering or making a bold, boho statement", imageName: "image7", category: "Neckband", originalPrice: 90.0, discountPercentage: 25),
        MyProduct(name: "Moonveil Pendant Necklace", price: 65.00, description: "A dreamy, hand-finished piece inspired by moonlight and boho charm — perfect for layering or wearing solo", imageName: "image3", category: "Necklaces", originalPrice: 90.0, discountPercentage: 10),
    ]

    @State private var selectedCategory: String = "All"
    let categories = ["All", "Anklets","Bracelets", "Earrings", "Head Pieces", "Necklaces", "Neckbands", "Rings"]

    var filteredProducts: [MyProduct] {
        selectedCategory == "All" ? products : products.filter { $0.category == selectedCategory }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {

                        Menu {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category)
                                }
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Text(selectedCategory)
                                    .font(.headline)
                                    .foregroundColor(.colorbackground)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.colorbackground)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                        }
                        .padding(.horizontal, 100)

                        Text("Featured")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.colorbackground)
                            .padding(.horizontal, 100)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(filteredProducts) { product in
                                    NavigationLink(destination: ProductDetailView(product: product).environmentObject(cartManager)) {
                                        productCard(for: product)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 100)
                        }

                        Text("Sale Items")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.colorbackground)
                            .padding(.horizontal, 100)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(saleItems) { product in
                                    NavigationLink(destination: ProductDetailView(product: product, isSale: true).environmentObject(cartManager)) {
                                        productCard(for: product, isSale: true)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 100)
                        }

                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButtonView()
                }
                ToolbarItem(placement: .principal) {
                    Text("Products")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.colorbackground)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
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

                        CartToolbarIcon()
                    }
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

    func productCard(for product: MyProduct, isSale: Bool = false) -> some View {
        VStack(alignment: .center, spacing: 6) {
            Image(product.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipped()
                .cornerRadius(10)

            VStack(spacing: 4) {
                Text(product.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.footnote)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                if isSale, let discount = product.discountPercentage {
                    Text("\(discount)% off")
                        .font(.caption)
                        .foregroundColor(.red)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(12)
        .shadow(radius: 7)
    }
}

struct ProductPageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductPageView()
            .environmentObject(CartManager())
    }
}
