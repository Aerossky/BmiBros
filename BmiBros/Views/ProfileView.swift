//
//  ProfileView.swift
//  BmiBros
//
//  Created by MacBook Pro on 26/05/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    
    @State private var username = ""
    
    @State private var profilePictureSelection: PhotosPickerItem?
    @State private var profilePictureObject: UIImage?
    
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var showPassword: Bool = false
    @State private var passwordSecurityCheckProgress: Double = 0
    @State private var isPasswordLengthValid: Bool = false
    @State private var showLogoutAlert = false
    @State private var showChangeUsernameAlert = false
    @State private var showChangePasswordAlert = false
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Profile picture") {
                    HStack {
                        Spacer()
                        VStack {
                            if let profilePictureObject {
                                Image(uiImage: profilePictureObject)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 150, height: 150)
                            }
                            PhotosPicker("Pick a profile picture", selection: $profilePictureSelection)
                                .onChange(of: profilePictureSelection) { newValue in
                                    Task(priority: .userInitiated) {
                                        if let newValue {
                                            // PhotosPickerItem -> Data -> UIImage -> SwiftUI Image
                                            if let loadedImageData = try? await
                                                newValue.loadTransferable(type: Data.self),
                                               // mac os use NSImage
                                               let loadedImage = UIImage(data: loadedImageData)
                                            {
                                                self.profilePictureObject = loadedImage
                                            }
                                        }
                                    }
                                }
                        }
                        Spacer()
                        
                    }
                }
                
                Section {
                    Text("Hello, \(userViewModel.loggedInUser?.username ?? "Admin")")
                    TextField("New Username", text: $username)
                        .keyboardType(.asciiCapable)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                } header: {
                    Text("Username")
                };
                
                Button(action: {
                    if let id = userViewModel.loggedInUser?.id {
                        userViewModel.updateUsername(id: id, newUsername: username)
                        showChangeUsernameAlert = true
                    }
                }) {
                    Text("Change Username")
                        .padding(.trailing)
                }
                .disabled(username.isEmpty)
                .alert(isPresented: $showChangeUsernameAlert) {
                    Alert(
                        title: Text("Success"),
                        message: Text("You have changed your username to \(userViewModel.loggedInUser?.username ?? "Admin")."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                Section("Password") {
                    HStack {
                        if showPassword {
                            TextField("New Password", text: $password)
                                .keyboardType(.asciiCapable)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField("New Password", text: $password)
                                .keyboardType(.asciiCapable)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        }
                        Button {
                            self.showPassword.toggle()
                        } label: {
                            Image(systemName: self.showPassword ? "eye" : "eye.slash")
                        }
                    }
                    if !password.isEmpty {
                        VStack(alignment: .leading) {
                            Label("minimal of 5 characters", systemImage: isPasswordLengthValid ? "checkmark" : "xmark")
                                .foregroundColor(isPasswordLengthValid ? .green : .red)
                        }
                        HStack {
                            Label("Password security", systemImage: passwordSecurityCheckProgress >= 0.5 ? "checkmark" : "xmark")
                                .foregroundColor(passwordSecurityCheckProgress >= 0.5 ? .green : .red)
                            
                            Gauge(value: passwordSecurityCheckProgress) {
                                // Gauge content
                            }
                        }
                    }
                    SecureField("Confirm Password", text: $passwordConfirmation)
                        .keyboardType(.asciiCapable)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    if !password.isEmpty, !passwordConfirmation.isEmpty, password != passwordConfirmation {
                        Label("Password confirmation does not match", systemImage: "xmark.circle")
                            .foregroundColor(.red)
                    } else if !password.isEmpty, !passwordConfirmation.isEmpty, password == passwordConfirmation {
                        Label("Password confirmation match", systemImage: "checkmark.circle")
                            .foregroundColor(.green)
                    }
                }
                .onChange(of: password) { newValue in
                    withAnimation {
                        self.passwordSecurityCheckProgress = isSecurePassword(newValue)
                        self.isPasswordLengthValid = newValue.count >= 5
                    }
                }
                
                Button(action: {
                    if let id = userViewModel.loggedInUser?.id {
                        userViewModel.updatePassword(id: id, newPassword: password)
                        showChangePasswordAlert = true
                    }
                }) {
                    Text("Change Password")
                        .padding(.trailing)
                }
                .disabled(!isPasswordLengthValid || passwordSecurityCheckProgress < 0.5)
                .alert(isPresented: $showChangePasswordAlert) {
                    Alert(
                        title: Text("Success"),
                        message: Text("You have changed your password."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                Section {
                    Button(action: {
                        userViewModel.logoutUser()
                        showLogoutAlert = true
                    }) {
                        Text("Sign Out")
                            .padding(.trailing)
                    }
                    .alert(isPresented: $showLogoutAlert) {
                        Alert(
                            title: Text("Success"),
                            message: Text("You have logged out."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .background(NavigationLink(destination: IntroductionView()
                        .navigationBarBackButtonHidden(true),
                                               label: {
                        EmptyView()
                    })
                    )
                }
                
            }
//            .navigationTitle("Profile Settings")
//            .navigationBarTitleDisplayMode(.inline)
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarTrailing) {
            //                    Button("Submit") {
            //                        // fill later
            //                    }
            //                    .disabled(!isPasswordLengthValid || passwordSecurityCheckProgress < 0.5)
            //                }
            //            }
        }
    }
    
    private func isSecurePassword(_ password: String) -> Double {
        var passwordStrengthScore: Double = 0
        
        let lowercaseLetterRegEx = ".*[a-z]+.*"
        let uppercaseLetterRegEx = ".*[A-Z]+.*"
        let digitRegEx = ".*[0-9]+.*"
        let specialCharacterRegEx = ".*[!@#$%^&*]+.*"
        
        let lowercaseLetterPredicate = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegEx)
        let uppercaseLetterPredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegEx)
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", digitRegEx)
        let specialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        
        if password.count >= 8 { passwordStrengthScore += 1 }
        if lowercaseLetterPredicate.evaluate(with: password) { passwordStrengthScore += 1 }
        if uppercaseLetterPredicate.evaluate(with: password) { passwordStrengthScore += 1 }
        if digitPredicate.evaluate(with: password) { passwordStrengthScore += 1 }
        if specialCharacterPredicate.evaluate(with: password) { passwordStrengthScore += 1 }
        
        return passwordStrengthScore / 5
    }
    
    private func isValidString(_ input: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_")
        let inputCharacters = CharacterSet(charactersIn: input)
        return allowedCharacters.isSuperset(of: inputCharacters)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SessionManager())
            .environmentObject(UserViewModel())
            .environmentObject(AppEnvironment())
    }
}
