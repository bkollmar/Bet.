//
//  SettingsPage.swift
//  Bet_Proto
//
//  Created by Ben Kollmar on 4/24/24.
//

import SwiftUI

struct SettingsPage: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Settings")
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
                        
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                        
                        .padding(.trailing, 10)
                        
                        NavigationLink(destination: FriendsPage().navigationBarBackButtonHidden()) {
                            Image(systemName: "person.2")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}
struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
