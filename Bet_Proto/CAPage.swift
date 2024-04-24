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
                        .padding(5)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                    
                    SecureField("Choose a Password", text: $createPassword)
                        .padding(5)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                    
                    SecureField("Confirm Your Password", text: $confirmPassword)
                        .padding(5)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: 250, height:30)
                    
                    TextField("Enter Your Email", text: $email)
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
                            .frame(width: 50)
                        
                        TextField("MM", text: $month)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 50)
                        
                        TextField("YYYY", text: $year)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 70)
                        
                    }
                    .padding(.bottom, 20)
                    
                    NavigationLink(destination: MainPage().navigationBarBackButtonHidden(true), isActive: $showingMainPage) {
                        Button("Start Betting"){
                            showingMainPage = true
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
}
struct CAPage_Previews: PreviewProvider {
    static var previews: some View {
        CAPage()
        
    }
}
