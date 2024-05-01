//
//  WalletPage.swift
//  Bet_Proto
//
//  Created by Ben Kollmar on 4/24/24.
//

import SwiftUI

struct WalletPage: View {
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack{
                Text("Wallet")
                    .foregroundColor(.white)
                    .padding()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                Spacer()
                
            }
        }
    }
}
struct WalletPage_Previews: PreviewProvider {
    static var previews: some View {
        WalletPage()
    }
}
