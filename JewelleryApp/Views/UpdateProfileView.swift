//
//  UpdateProfileView.swift
//  Velora Jewellery
//
//  Created by Cristina Cabral on 2025-05-02.
//

import SwiftUI

struct UpdateProfileView: View {
    @Environment(\.dismiss) var dismiss

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var address: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        Group {
                            TextField("Full Name", text: $fullName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            TextField("Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)

                            TextField("Phone Number", text: $phoneNumber)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.phonePad)

                            TextField("Default Address", text: $address)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.horizontal)

                        Button(action: {
                            print("Profile updated")
                            dismiss()
                        }) {
                            Text("Save")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.colorbackground)
                                .cornerRadius(10)
                                .opacity(0.7)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 40)
                }
            }
            .navigationTitle("Update Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.colorbackground)
                        .font(.system(size: 16, weight: .medium))
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct UpdateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView()
    }
}
