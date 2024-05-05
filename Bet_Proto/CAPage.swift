//
//  CAPage.swift
//  Bet_Proto
//
//  Created by Ben Kollmar on 4/24/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CAPage: View {
    @State private var username = ""
    @State private var createPassword = ""
    @State private var confirmPassword = ""
    @State private var email = ""
    @State private var day: String = ""
    @State private var month: String = ""
    @State private var year: String = ""
    @State private var showingMainPage = false
    @State private var userNameEmpty = false
    @State private var passwordEmpty = false
    @State private var confirmPasswordEmpty  = false
    @State private var emailEmpty = false
    @State private var dayEmpty = false
    @State private var monthEmpty = false
    @State private var yearEmpty = false
    
    
    
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                VStack{
                    
                    Text("Create Your Account")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 70)
                    
                    TextField("Choose a Username", text: $username)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(userNameEmpty ? Color.red : Color.clear, lineWidth: 2)
                                .padding(-4)
                        )
                        .padding(7)
                        .colorScheme(.dark)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                        .padding(.bottom, 10)
                    
                    TextField("Enter Your Email", text: $email)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(emailEmpty ? Color.red : Color.clear, lineWidth: 2)
                                .padding(-4)
                        )
                        .padding(7)
                        .colorScheme(.dark)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                        .padding(.bottom, 10)
                    
                    
                    SecureField("Choose a Password", text: $createPassword)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(passwordEmpty ? Color.red : Color.clear, lineWidth: 2)
                                .padding(-4)
                        )
                        .padding(7)
                        .colorScheme(.dark)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                        .padding(.bottom, 10)
                    
                    SecureField("Confirm Your Password", text: $confirmPassword)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(confirmPasswordEmpty ? Color.red : Color.clear, lineWidth: 2)
                                .padding(-4)
                        )
                    
                        .padding(7)
                        .colorScheme(.dark)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                    
                    
                    
                    Text("Enter Your Birth Date")
                        .padding()
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 10) {
                        TextField("DD", text: $day)
                            .padding()
                            .border(dayEmpty ? Color.red : Color.clear)
                            .frame(width: 61)
                            .colorScheme(.dark)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                        TextField("MM", text: $month)
                            .padding()
                            .border(monthEmpty ? Color.red : Color.clear)
                            .frame(width: 61)
                            .colorScheme(.dark)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                        
                        TextField("YYYY", text: $year)
                            .padding()
                            .border(yearEmpty ? Color.red : Color.clear)
                            .frame(width: 75)
                            .colorScheme(.dark)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                        
                    }
                    .padding(.bottom, 20)
                    
                    VStack {
                        NavigationLink(destination: MainPage().navigationBarBackButtonHidden(true), isActive: $showingMainPage) {
                        }
                        Button("Start Betting"){
                            register()
                            
                        }
                        .padding(7)
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.6))
                        .cornerRadius(10)
                        .frame(width:200, height:20)
                        
                    }
                }
            }
        }
    }
    
    func register(){
        if day.isEmpty {
            dayEmpty = true
        } else {
            dayEmpty = false
        }
        if month.isEmpty {
            monthEmpty = true
        } else {
            monthEmpty = false
        }
        if year.isEmpty {
            yearEmpty = true
        } else {
            yearEmpty = false
        }
        if createPassword.isEmpty {
            passwordEmpty = true
        } else {
            passwordEmpty = false
        }
        if confirmPassword.isEmpty {
            confirmPasswordEmpty = true
        } else {
            confirmPasswordEmpty = false
        }
        if email.isEmpty {
            emailEmpty = true
        } else {
            emailEmpty = false
        }
        if username.isEmpty {
            userNameEmpty = true
        } else {
            userNameEmpty = false
        }
        
        
        if !day.isEmpty  && !month.isEmpty && !year.isEmpty && !email.isEmpty && !createPassword.isEmpty && !confirmPassword.isEmpty && !username.isEmpty
        {
             createUser()
             createUserProfile()
        }
        
    }
    
    func createUser() {
        Auth.auth().createUser(withEmail: email, password: createPassword) { authResult, error in
            if let error = error {
                print("Error adding document")
            } else {
                showingMainPage = true
            }
        }
    }
    
    func createUserProfile() {
        let db = Firestore.firestore()
                let user = Auth.auth().currentUser
                
                if let user = user {
                    // Document path can be customized as per your requirements
                    let userProfileRef = db.collection("users").document(user.uid)
                    
                    let userData: [String: Any] = [
                        "email": user.email ?? "",
                        "username" : username,
                        "profilePicture" : ""
                        // Add more fields as needed
                    ]
                    
                    // Set the data in Firestore
                    userProfileRef.setData(userData) { error in
                        if let error = error {
                            print("Error adding document")
                        } else {
                            print("User profile created successfully")
                        }
                    }
                }
            }
    
    struct CAPage_Previews: PreviewProvider {
        static var previews: some View {
            CAPage()
            
        }
    }
}
