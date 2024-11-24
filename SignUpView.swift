//
//  SignUpView.swift
//  final test
//
//  Created by Amit Sureka on 12/01/24.
//

import SwiftUI
import SwiftData
struct SignUpView: View {
    @Query var users: [User]
    
    @State private var userId: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showingPasswordMismatchAlert: Bool = false
    @State private var showingUsernameExistsAlert = false
    @State private var showingPasswordShortAlert=false
    @State private var showingEmptyAlert: Bool = false
    @State var path:NavigationPath
    //@StateObject private var accountobject = Accounts()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
      var body: some View {
          NavigationView {
              ZStack{
                  Color.blue.opacity(0.8)
                      .ignoresSafeArea()
                  Circle()
                      .scale(1.70)
                      .foregroundColor(.white.opacity(0.35))
                  Circle()
                      .scale(1.5)
                      .foregroundColor(.white)
                  VStack {
                      Image(systemName: "person.crop.circle.fill")
                          .resizable()
                          .scaledToFit()
                          .frame(width: 100, height: 70)
                          .foregroundColor(.gray)
                          .padding(.bottom, 60)
                          .padding(-40)
                      
                      TextField("User ID", text: $userId)
                          .padding()
                          .frame(width: 300, height: 50)
                          .background(Color.black.opacity(0.05))
                          .cornerRadius(10)
                      
                      SecureField("New Password", text: $newPassword)
                          .padding()
                          .frame(width: 300, height: 50)
                          .background(Color.black.opacity(0.05))
                          .cornerRadius(10)
                          .padding(.horizontal, 40)
                          .padding(.top, 10)
                      
                      SecureField("Confirm New Password", text: $confirmPassword)
                          .padding()
                          .frame(width: 300, height: 50)
                          .background(Color.black.opacity(0.05))
                          .cornerRadius(10)
                          .padding(.horizontal, 40)
                          .padding(.top, 10)
                      Button(action:signUp) {
                          Text("Sign Up")
                              .foregroundColor(.white)
                              .frame(maxWidth: .infinity)
                              .frame(height: 20)
                              .padding()
                              .background(Color.blue.opacity(0.8))
                              .cornerRadius(10)
                      }
                      .padding(.horizontal, 40)
                      .padding(.top, 10)
                      .alert("Passwords do not match", isPresented: $showingPasswordMismatchAlert) {
                          Button("OK", role: .cancel) { }
                      }
                      .alert("An account with this username already exists.", isPresented: $showingUsernameExistsAlert) {
                          Button("Cancel", role: .cancel) {
                              userId = ""
                              newPassword = ""
                              confirmPassword = ""
                          }
                      }
                      .alert("Password cannot be less than eight characters.",isPresented:$showingPasswordShortAlert){
                          Button("OK",role: .cancel){
                              newPassword=""
                              confirmPassword=""
                          }
                      }
                      .alert("Enter valid credentials", isPresented: $showingEmptyAlert) {
                          Button("OK", role: .cancel) {
                              userId = ""
                              newPassword = ""
                              confirmPassword = ""
                          }
                      }
                      
                      Button("Cancel"){
                          dismiss()
                      }
                          .foregroundColor(.white)
                          .frame(height: 20)
                          .frame(maxWidth: .infinity)
                          .padding()
                          .background(Color.red)
                          .cornerRadius(10)
                          .padding(.horizontal, 40)
                          .padding(.top, 10)
                  }
                  //.padding() // Repositioned a bit up
                  .navigationTitle("Create New Account")
                  .navigationBarTitleDisplayMode(.inline)
              }
            }
              
      }
      
      func signUp() {
          if userId.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty {
              showingEmptyAlert=true
          }
          
          if users.map{ $0.username }.contains(userId) {
              showingUsernameExistsAlert.toggle()
              return
          }
          
          else{
              if newPassword != confirmPassword {
                  showingPasswordMismatchAlert = true
              }
              else if confirmPassword.count<8{
                  showingPasswordShortAlert=true
              }
              
              else {
                  // Handle sign up logic here
                  addUser()
                  //LoginView(navigationpath: $path)
                  //dismiss()
              }
          }

      }
    func addUser(){
        let user=User(username: userId, password: newPassword)
        context.insert(user)
        path.append(user)
        dismiss()
        print("something")
    }
}

