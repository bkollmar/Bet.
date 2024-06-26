//
//  FriendsPage.swift
//  Bet_Proto
//
//  Created by Ben Kollmar on 4/24/24.
//

import SwiftUI

struct FriendsPage: View {
    @State private var isFriendAdded = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Friends")
                            .foregroundColor(.white)
                            .padding()
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        NavigationLink(destination: ProfilePage().navigationBarBackButtonHidden()) {
                            Image(systemName: "person")
                                .foregroundColor(.white)
                        }
                        
                        .padding(.trailing, 10)
                        
                        NavigationLink(destination: WalletPage().navigationBarBackButtonHidden()) {
                            Image(systemName: "wallet.pass")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 10)
                        
                        NavigationLink(destination: SettingsPage().navigationBarBackButtonHidden()) {
                            Image(systemName: "gear")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 10)
                        
                        Image(systemName: "person.2")
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Add Friends")
                            .padding()
                            .foregroundColor(.white)
                            .font(.title)
                        Button(action: {
                            // Action for button tap
                        }) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 60)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    ScrollView {
                        VStack(spacing: 20) {
                            if !isFriendAdded {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white)
                                    .frame(width: 350, height: 100)
                                
                                    .overlay(
                                        HStack {
                                            Spacer()
                                            VStack {
                                                Image(systemName: "person.circle")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 60)
                                                Text("John Smith")
                                                    .fontWeight(.bold)
                                            }
                                            Button(action: {
                                                withAnimation {
                                                    isFriendAdded.toggle()
                                                }
                                            }) {
                                                
                                                Spacer() // move to the left
                                                
                                                Text("Add Friend")
                                                    .foregroundColor(.white)
                                                    .padding(10)
                                                    .background(Color.black.opacity(0.8))
                                                    .cornerRadius(10)
                                                    .frame(width: 175, height: 10)
                                            }
                                        }
                                    )
                                    .opacity(isFriendAdded ? 0.5 : 1.0)
                                    .animation(.easeInOut(duration: 0.5))
                            }
                            
                            Spacer()
                        }
                        
                        VStack {
                            Text("Friends")
                                .padding()
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.white)
                                
                            HStack {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 60)
                                    .foregroundColor(.white)
                                Button(action: {
                                    // Action for button tap
                                }) {
                                    Text("Sean River")
                                        .foregroundColor(.white)
                                        .font(.title)
                                }
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 60)
                                    .foregroundColor(.white)
                                Button(action: {
                                    // Action for button tap
                                }) {
                                    Text("Steven Black")
                                        .foregroundColor(.white)
                                        .font(.title)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}
struct FriendsPage_Previews: PreviewProvider {
    static var previews: some View {
        FriendsPage()
    }
}
