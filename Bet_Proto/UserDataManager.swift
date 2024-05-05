//
//  UserDataManager.swift
//  Bet_Proto
//
//  Created by Ben Kollmar on 5/1/24.
//

//import Foundation
//
//struct User: Codable{
//    var createUsername: String
//    var createPassword: String
//    var email: String
//    var day: String
//    var month: String
//    var year: String
//}
//
//class UserDataManager {
//    static let shared = UserDataManager()
//    private let userDefaults = UserDefaults.standard
//    private let userKey = "users"
//    
//    func saveUser(_ user: User) {
//        var users = getUsers()
//        users.append(user)
//        saveUsers(users)
//    }
//    
//    func getUsers() -> [User] {
//        if let userData = userDefaults.data(forKey: userKey),
//           let users = try? JSONDecoder().decode([User].self, from: userData) {
//            return users
//        } else {
//            return []
//        }
//    }
//    
//    private func saveUsers(_ users: [User]) {
//        if let userData = try? JSONEncoder().encode(users) {
//            userDefaults.set(userData, forKey: userKey)
//        }
//    }
//}
