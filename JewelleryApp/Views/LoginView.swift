//
//  LoginView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-05.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            VStack {
                // Login Button (Top Right)
                HStack {
                    
                }

                
                Spacer()
                
                // Subtitle with Icons on Both Sides
                HStack {
                    Text("VELORA JEWELERY")
                        .font(.system(size: 30, weight: .medium))
                        .foregroundColor(.gray)
                        .padding(.bottom, 50)
                }
       
                
                // Email Field
                TextField("EMAIL:", text: $email)
                    .font(.system(size: 20, weight: .medium))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 40)
                
                // Password Field
                SecureField("PASSWORD:", text: $password)
                    .font(.system(size: 20, weight: .medium))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                // Login Button
                Button(action: {
                    print("Login button tapped")
                }) {
                    Text("Login")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(5.0)
                }
                .padding(.bottom, 50)
                

                
               
                .padding(.bottom, 20) // Adjust this padding to move the button up
                
                Spacer()
            }
            .padding(.top, 40)
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    LoginView()
}
