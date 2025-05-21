//
//  ContentView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-05.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    // Welcome Text
                    Text("WELCOME")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.colorbackground)
                        .padding(.bottom, 60)

                    // Subtitle with Icons
                    HStack {
                        Image(systemName: "diamond.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.colorbackground)
                        Text("VELORA JEWELLERY")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.colorbackground)
                        Image(systemName: "diamond.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.colorbackground)
                    }
                    .padding(.bottom, 45)

                    // Featured Image
                    Image("featured")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 220)
                        .clipShape(Rectangle())
                        .padding(.bottom, 120)

                    Spacer()

                    // Sign Up Text
                    Text("SIGN UP TO\nGET NOTIFIED!")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.colorbackground)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)

                    // Sign-Up Button
                    NavigationLink(destination: SignUpView()) {
                        Image(systemName: "chevron.down.circle")
                            .font(.largeTitle)
                            .foregroundColor(.colorbackground)
                    }
                    .padding(.bottom, 20)

                    Spacer()
                }
                .padding(.top, 40)

                // Top-right Login Button
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.colorbackground)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                        }
                    }
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.trailing, 110)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
            .environmentObject(CartManager())
    }

