//
//  LoginView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-05.
//
import SwiftUI


struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSecure = true
    @State private var navigateToProductPage = false

    @EnvironmentObject var cartManager: CartManager  // 👈 VERY important!

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()

                    Text("VELORA JEWELLERY")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.colorbackground)
                        .multilineTextAlignment(.center)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email:")
                            .foregroundColor(.colorbackground)
                        TextField("Enter your email", text: $email)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password:")
                            .foregroundColor(.colorbackground)
                        HStack {
                            if isSecure {
                                SecureField("Enter your password", text: $password)
                            } else {
                                TextField("Enter your password", text: $password)
                            }
                            Button {
                                isSecure.toggle()
                            } label: {
                                Image(systemName: isSecure ? "eye.slash" : "eye")
                                    .foregroundColor(.colorbackground)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    Button("Forgot Password?") {
                        print("Forgot password tapped")
                    }
                    .foregroundColor(.colorbackground)
                    .font(.footnote)

                    Button {
                        navigateToProductPage = true
                    } label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.colorbackground.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.colorbackground)
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .foregroundColor(.colorbackground)
                        }
                    }

                    Spacer()
                }
                .frame(maxWidth: 400)
                .padding(.top, 40)
            }
            .navigationTitle("")
            .navigationBarHidden(true)

            // ✅ Navigation fixed with EnvironmentObject
            .navigationDestination(isPresented: $navigateToProductPage) {
                ProductPageView()
                    .environmentObject(cartManager)  // 👈 FIX: Pass cartManager when navigating!
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(CartManager())
}
