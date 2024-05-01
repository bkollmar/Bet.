//
//  CAPage.swift
//  Bet_Proto
//
//  Created by Ben Kollmar on 4/24/24.
//

import SwiftUI

struct CAPage: View {
    @State private var createUsername = ""
    @State private var createPassword = ""
    @State private var confirmPassword = ""
    @State private var email = ""
    @State private var day: String = ""
    @State private var month: String = ""
    @State private var year: String = ""
    @State private var showingMainPage = false
    @State private var passwordMismatch = false
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
                    
//                    Text("Bet.")
//                        .foregroundColor(.white)
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .padding(.top, -200)
//                        .padding(.bottom, 10)
//                        .padding(.trailing, 300)
                    
                    Text("Create Your Account")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 100)
                    
                    TextField("Choose a Username", text: $createUsername)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(userNameEmpty ? Color.red : Color.clear, lineWidth: 2)
                                    .padding(-4)
                            )
                        .padding(5)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                        
                    
                    SecureField("Choose a Password", text: $createPassword)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(passwordEmpty ? Color.red : Color.clear, lineWidth: 2)
                                    .padding(-4)
                            )
                        .padding(5)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                    
                    SecureField("Confirm Your Password", text: $confirmPassword)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(confirmPasswordEmpty ? Color.red : Color.clear, lineWidth: 2)
                                    .padding(-4)
                            )
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(passwordMismatch ? Color.red : Color.clear, lineWidth: 2)
                                    .padding(-4)
                            )
                        .padding(5)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                    
                    TextField("Enter Your Email", text: $email)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(emailEmpty ? Color.red : Color.clear, lineWidth: 2)
                                    .padding(-4)
                            )
                        .padding(5)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                    
                    Text("When Were You Born")
                        .padding()
                        .foregroundColor(.white)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 10) {
                        TextField("DD", text: $day)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .border(dayEmpty ? Color.red : Color.clear)
                            .frame(width: 50)
                        
                        TextField("MM", text: $month)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .border(monthEmpty ? Color.red : Color.clear)
                            .frame(width: 50)
                        
                        TextField("YYYY", text: $year)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .border(yearEmpty ? Color.red : Color.clear)
                            .frame(width: 70)
                        
                    }
                    .padding(.bottom, 20)
                
                    VStack {
                        NavigationLink(destination: MainPage().navigationBarBackButtonHidden(true), isActive: $showingMainPage) {
                                }
                        Button("Start Betting"){
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
                            if createUsername.isEmpty {
                                userNameEmpty = true
                            } else {
                                userNameEmpty = false
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
                            
                            if createPassword == confirmPassword { // Check if passwords match
                                passwordMismatch = false // Reset password mismatch state
                            } else {
                                passwordMismatch = true
                            }
                            if !day.isEmpty && createPassword == confirmPassword && !month.isEmpty && !year.isEmpty && !email.isEmpty && !createUsername.isEmpty && !createPassword.isEmpty && !confirmPassword.isEmpty
                            {
                                showingMainPage = true
                                createAccount()
                                printUsers()
                            }
                            
                        }
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .frame(width:200, height:20)
                    }
                }
            }
        }
    }
    func createAccount() {
        // Validate input, for example, ensure passwords match, etc.
        
        // Create a User object
        
        let newUser = User(createUsername: createUsername,
                          createPassword: createPassword,
                          email: email,
                          day: day,
                          month: month,
                          year: year)

        // Save the user using UserDataManager
        UserDataManager.shared.saveUser(newUser)

        // Set showingMainPage to true to navigate to the next page
        showingMainPage = true
    }
    func printUsers() {
        let userManager = UserDataManager.shared
        let users = userManager.getUsers()

        // Now you can use the 'users' array to access the list of signed-up users
        for user in users {
            print("Username: \(user.createUsername)")
            print("Email: \(user.email)")
        }
                  
    }
}
struct CAPage_Previews: PreviewProvider {
    static var previews: some View {
        CAPage()
        
    }
}
