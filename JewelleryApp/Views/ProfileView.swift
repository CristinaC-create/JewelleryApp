//
//  ProfileView.swift
//  JewelleryApp
//
//  Created by Cristina Cabral on 2025-02-12.
//
// ProfileView.swift
// ProfileView.swift
import SwiftUI
import PhotosUI

struct ProfileView: View {
    let user: User
    @Environment(\.presentationMode) var presentationMode

    @State private var navigateToUpdateProfile = false
    @State private var navigateToLogin = false
    @State private var showLogoutConfirm = false
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 4) {
                            Text("Welcome back, \(user.name)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.colorbackground)

                            Text("Profile")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.colorbackground)
                        }
                        .padding(.top, 50)

                        ZStack(alignment: .bottomTrailing) {
                            Group {
                                if let image = selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                } else if let uiImage = UIImage(named: user.profileImage) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.gray)
                                }
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 5)

                            Button(action: {
                                isImagePickerPresented = true
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.colorbackground)
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            .offset(x: 5, y: 5)
                        }

                        Text(user.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.colorbackground)

                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.colorbackground)

                        Divider()
                            .background(Color.colorbackground)

                        VStack(spacing: 15) {
                            NavigationLink(destination: WishlistView()) {
                                ProfileOptionRow(icon: "heart.fill", text: "Wishlist")
                            }

                            NavigationLink(destination: OrderHistoryView()) {
                                ProfileOptionRow(icon: "cart.fill", text: "Order History")
                            }
                        }

                        Divider()
                            .background(Color.gray)

                        Button(action: {
                            showLogoutConfirm = true
                        }) {
                            Text("Log Out")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.colorbackground)
                                .opacity(0.7)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        .padding(.top, 25)

                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.colorbackground)
                        .font(.system(size: 16, weight: .medium))
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Update Profile") {
                            navigateToUpdateProfile = true
                        }
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.colorbackground)
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToUpdateProfile) {
                UpdateProfileView()
            }
            .navigationDestination(isPresented: $navigateToLogin) {
                ContentView()
            }
            .alert("Log Out?", isPresented: $showLogoutConfirm) {
                Button("Cancel", role: .cancel) {}
                Button("Log Out", role: .destructive) {
                    navigateToLogin = true
                }
            } message: {
                Text("Are you sure you want to log out?")
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
}

struct ProfileOptionRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.colorbackground)
            Text(text)
                .font(.headline)
                .foregroundColor(.colorbackground)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(name: "Sophia Bennett", email: "sophia@example.com", profileImage: "profile_placeholder"))
    }
}
