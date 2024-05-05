//
//  MainPage.swift
//  Bet_Proto
//
//  Created by Ben Kollmar on 4/23/24.
//

import SwiftUI

struct MainPage: View {
    @State private var amount = ""
    @State private var userBetting = ""
    @State private var userBettingNote = ""
    @State private var referee = ""
    @State private var isClicked: Bool = false
    @State private var isClicked2: Bool = false
    @State private var showTextField: Bool = false
    var body: some View {
        NavigationView{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                VStack {
                    HStack{
                        Text("Bet.")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top)
                        Spacer()
                        Spacer()
                        
                        NavigationLink(destination: ProfilePage()) {
                            Image(systemName: "person")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 10)
                        
                        NavigationLink(destination: WalletPage()) {
                            Image(systemName: "wallet.pass")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 10)
                        
                        NavigationLink(destination: SettingsPage()) {
                            Image(systemName: "gear")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 10)
                        
                        NavigationLink(destination: FriendsPage()) {
                            Image(systemName: "person.2")
                                .foregroundColor(.white)
                        }
                        
                    }
                    
                    TextField("$", text: $amount)
                        .padding()
                        .frame(width: 150, height: 150)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .keyboardType(.numberPad) // Restrict input to numbers only
                        .font(.system(size: 40))
                        .multilineTextAlignment(.center)
                        .padding(.top, 100) // Add padding to move the text field down
                    
                    TextField("Who Do You Want To Bet?", text: $userBetting)
                        .padding(6)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .frame(width: 235, height: 50)
                        .padding(.top, 30) // Add padding to move the text field down
                    
                    TextField("What Are You Betting On?", text: $userBettingNote)
                        .padding(6)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .frame(width: 235, height: 50)
                    
                    
                    
                    HStack{
                        Button(action: {
                            self.isClicked2.toggle()
                            if self.isClicked {
                                self.isClicked2 = false
                            }
                            self.showTextField.toggle() // Toggle text field visibility
                                }) {
                                    Text("Add a Ref")
                                }
                                .foregroundColor(.white)
                                .frame(width: 110, height: 30)
                                .background(isClicked2 ? Color.green.opacity(0.7) : Color.gray.opacity(0.5))
                                .cornerRadius(10)
                        Button(action: {
                            self.isClicked.toggle()
                            if self.isClicked2 {
                                self.isClicked = false
                            }
                                }) {
                                    Text("Trust User")
                                }
                                .foregroundColor(.white)
                                .frame(width: 110, height: 30)
                                .background(isClicked ? Color.green.opacity(0.7) : Color.gray.opacity(0.5))
                                .cornerRadius(10)
                                
                    }
                    if showTextField{
                        TextField("Enter Username for Referee", text: $referee)
                            .padding(5)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .frame(width: 235, height: 50)
                    }
                    Button("Bet."){
                        // Action to Perform
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 110, height: 30)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                    Spacer()
                }
                
                
            }
            .navigationBarBackButtonHidden(true)
            
        }
        
    }
}
    
struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
