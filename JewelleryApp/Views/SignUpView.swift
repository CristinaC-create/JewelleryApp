//
//  SignUpView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-12.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true
    @State private var navigateToProductPage = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    Text("VELORA JEWELLERY")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.colorbackground)

                    Spacer().frame(height: 50)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email:")
                        TextField("Enter your email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 30)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password:")
                        HStack {
                            if isSecure {
                                SecureField("Enter your password", text: $password)
                            } else {
                                TextField("Enter your password", text: $password)
                            }

                            Button(action: { isSecure.toggle() }) {
                                Image(systemName: isSecure ? "eye.slash" : "eye")
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    .padding(.bottom, 30)

                    Button("Sign Up") {
                        navigateToProductPage = true
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.colorbackground.opacity(0.7))
                    .cornerRadius(8)

                    Spacer()
                }
                .padding(.horizontal, 110)
            }
            .navigationDestination(isPresented: $navigateToProductPage) {
                ProductPageView().environmentObject(CartManager())
            }
            .navigationBarHidden(true)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(CartManager())
    }
}
