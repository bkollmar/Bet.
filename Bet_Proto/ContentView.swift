//
//  ContentView.swift
//  Bet_Proto
//
//  Created by Ben Kollmar on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingMainPage = false
    @State private var showingCAPage = false
    @State private var showingSettingsPage = false
    @State private var showingProfilePage = false
    @State private var showingFriendsPage = false
    @State private var showingWalletPage = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                VStack{
                    Text("Bet.    Anyone Anytime Everywhere")
                        .foregroundColor(.white)
                        .font(.system(size: 70))
                        .bold()
                        .padding(.top, -250)
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .border(.red, width:CGFloat(wrongUsername))
                        .colorScheme(.dark)
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .border(.red, width:CGFloat(wrongPassword))
                        .foregroundColor(.white)
                        .colorScheme(.dark)
                        .padding(.bottom, 20)
                    HStack{
                        
                        Button("Login"){
                            authenticateUser(username: username, password: password)
                            
                        }
                        
                        .foregroundColor(.white)
                        .frame(width: 140, height: 30)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .padding(.trailing, 8)
                        
                        NavigationLink(destination: MainPage().navigationBarBackButtonHidden(true), isActive: $showingMainPage){
                            EmptyView()
                        }
                        
                        NavigationLink(destination: CAPage(), isActive: $showingCAPage){
                            Button("Register"){
                                goToCaPage()
                            }
                            
                            .foregroundColor(.white)
                            .frame(width: 140, height: 30)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(10)
                            .padding(.leading, 8)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            
        }
        
    }

    func authenticateUser(username: String, password: String){
        if username == "Ben" {
            wrongUsername = 0
            if password == "123" {
                wrongPassword = 0
                showingMainPage = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
    
    func goToCaPage() {
        showingCAPage = true
    }
    
}

#Preview {
    ContentView()
}
