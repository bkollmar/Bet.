//
//  ReusableProfileContent.swift
//  Bet_Proto
//
//  Created by Ben Kollmar on 5/8/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReusableProfileContent: View {
    var user: User
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack{
                HStack(spacing:12){
                    if user.userProfileURL != nil {
                        WebImage(url: user.userProfileURL)
                           .resizable()
                           .aspectRatio(contentMode: .fill)
                           .frame(width: 100, height: 100)
                           .clipShape(Circle())
                           .foregroundColor(.white)
                       } else {
                           Image(systemName: "person")
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                               .frame(width: 100, height: 100)
                               .clipShape(Circle())
                               .foregroundColor(.white)
                       }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(user.username)
                            .padding(50)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
