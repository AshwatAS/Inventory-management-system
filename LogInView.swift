//
//  LogInView.swift
//  final test
//
//  Created by Amit Sureka on 12/01/24.
//

import SwiftUI
import SwiftData
struct LoginView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme
    @State private var username = ""
    @State private var password = ""
    
    @State private var isUsernameWrong = false
    @State private var isPasswordWrong = false
    
    @State private var count = 0
    @State var selectedUser: User?
    @State private var showingemptyAlert=false
    @State private var isNavigationActive = false
    //@State var isViewHidden:Bool
    @Binding var navigationpath: NavigationPath
    //@Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Query var users:[User]
    //@State private var showingLoginScreen = false
    //@StateObject private var accountobject = Accounts()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(colorScheme == .light ? .white : Color(uiColor: .systemGray))
                
                VStack {
                    Spacer()
                    Text("Cauvery Industrials")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(isUsernameWrong ? Color.red.opacity(0.5) : Color.black.opacity(0.05))
                        .cornerRadius(10)
                        
                    
                    
                    SecureField("Password", text: $password)
                        .submitLabel(.done)
                        .onSubmit {
                            authenticateUser(username: username, password: password)
                        }
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(isPasswordWrong ? Color.red.opacity(0.5) : Color.black.opacity(0.05))
                        .cornerRadius(10)
                        //.border(.red, width: CGFloat(wrongPassword))
                        .padding(0.2)
                        .padding(-45)
                        .padding(55)
                    //                    NavigationLink(destination: TableView()) {
                    //                        Text("Sign In")
                    //                            .foregroundColor(.white)
                    //                            .frame(width: 300, height: 50)
                    //                            .background(Color.black)
                    //                            .cornerRadius(10)
                    //                    }.onTapGesture {
                    //                        authenticateUser(username: username, password: password)
                    //                    }
                    Button { 
                        //isAdmin=false
                        authenticateUser(username: username, password: password)
                    } label: {
                        Text("Sign In")
                        
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .alert("Enter credentials", isPresented: $showingemptyAlert) {
                        Button("OK", role: .cancel) {
                            showingemptyAlert=false
                        }
                    }
                    Spacer()
                    
                    NavigationLink(destination: SignUpView(path: navigationpath).navigationBarBackButtonHidden(true)) {
                        Text("Create an Account")
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                    }.navigationBarHidden(true)
                    .navigationDestination(item: $selectedUser) { user in
                        TableView(user: user)
                            .navigationBarBackButtonHidden()
                    }
                }
            }
        }
        .onChange(of: username) {
            isUsernameWrong = false
        }
        .onChange(of: password) {
            isPasswordWrong = false
        }
    }
    func authenticateUser(username: String, password: String) {
        
        if username != "" && password != "" {
            if let user = users.first(where: { $0.username == username && $0.password == password}) {
                selectedUser=user
                isNavigationActive.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.username = ""
                    self.password = ""
                }
            } else if users.first(where: { $0.username == username }) != nil {
                isPasswordWrong = true
            } else {
                isUsernameWrong = true 
            }
        }

        else{
            showingemptyAlert.toggle()
        }
    }
//        ForEach(users){ user in
//            if username==user.username && password==user.password{
//                //wrongUsername=0
//                //wrongPassword=0
//                NavigationLink(destination: TableView()){
//                }
//                //print("true")
//            }
//            else if username != user.username || username=="" || password==""{
//                //wrongUsername=2
//            }
//            else{
//                //wrongPassword=2
//                NavigationLink(destination:LoginView(navigationpath: $navigationpath)){
//                    Text("Wrong password")
//                }
//            }
//        }


//        for index in users{
//            if username==users[index].username && password==users[index].password{
//                wrongUsername=0
//                wrongPassword=0
////                NavigationLink(destination: TableView()){
////                }
//                print("true")
//            }
//            else if username != users.username[index]{
//                wrongUsername=2
//            }
//            else{
//                wrongPassword=2
//            }
//        }
//        if username.lowercased() == "mario2021" {
//            wrongUsername = 0
//            if password.lowercased() == "abc123" {
//                wrongPassword = 0
//                //showingLoginScreen = true
//            } else {
//                wrongPassword = 2
//            }
//        } else {
//            wrongUsername = 2
//        }
    //}
}


//    #Preview {
//        LoginView()
//    }

