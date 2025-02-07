//
//  ContentView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background Image
            Image("background") // Replace with your background image asset
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Login Button (Top Right)
                HStack {
                    Spacer() // Pushes "LOGIN" to the right
                    Text("Login")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .padding(.trailing, 45)
                }
                .padding(.top, 50)
                
                Spacer()
                
                // Welcome Text
                Text("WELCOME")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.bottom, 60) // Adjust this padding to move the text up
                
                // Subtitle with Icons on Both Sides
                HStack {
                    Image(systemName: "diamond.circle.fill") // Left icon
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    Text("VELORA JEWELERY")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.gray)
                    Image(systemName: "diamond.circle.fill") // Right icon
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 45) // Adjust this padding to move the text up
                
                // Featured Image
                Image("featured") // Replace with your jewelry image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 180)
                    .clipShape(Rectangle())
                    .padding(.bottom, 120) // Adjust this padding to move the image up
                
                Spacer()
                
                // Sign Up Text
                Text("SIGN UP TO\nGET NOTIFIED!")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20) // Adjust this padding to move the text up
                
                // Arrow Button
                Button(action: {
                    print("Navigate Down")
                }) {
                    Image(systemName: "chevron.down.circle")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 20) // Adjust this padding to move the button up
                
                Spacer()
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    ContentView()
}
