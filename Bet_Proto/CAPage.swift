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
import PhotosUI
import FirebaseStorage

struct CAPage: View {
    @State private var profilePicture: UIImage? = nil
    @State var userProfilePicData: Data?
    
    @State var userName = ""
    @State private var friends = []
    @State private var createPassword = ""
    @State private var confirmPassword = ""
    @State var email = ""
    @State var password = ""
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
    
    
    // MARK: - View Properties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
   
    // MARK: - UserDefaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
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
                        .padding(.bottom, 20)
                    
                    .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
                    .onChange(of: photoItem) { newValue in
                        // Extracting UIImage From PhotoItem
                        if let newValue {
                            Task {
                                do {
                                    guard let imageData = try await newValue.loadTransferable(type: Data.self) else { return }
                                    // Must update on Main Thread
                                    await MainActor.run {
                                        userProfilePicData = imageData
                                    }
                                } catch {
                                    await setError(error)
                                }
                            }
                        }
                    }
                    .alert(errorMessage, isPresented: $showError, actions: {})
                    
                    ZStack {
                        if let userProfilePicData, let image = UIImage(data: userProfilePicData) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.white)
                                .padding()
                        } else {
                            Image(systemName: "person")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    .frame(width: 85, height: 85)
                    .clipShape(Circle())
                    .contentShape(Circle())
                    .onTapGesture {
                        showImagePicker.toggle()
                    }
                    
                    TextField("Username", text: $userName)
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
                    
                    TextField("E-mail", text: $email)
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
                    
                    SecureField("Password", text: $createPassword)
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
                    
                    SecureField("Confirm Password", text: $confirmPassword)
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
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
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
        if userName.isEmpty {
            userNameEmpty = true
        } else {
            userNameEmpty = false
        }
        
        if !day.isEmpty  && !month.isEmpty && !year.isEmpty && !email.isEmpty && !createPassword.isEmpty && !confirmPassword.isEmpty && !userName.isEmpty
        {
            createUser()
            showingMainPage = true
            return
        }
    }
    
    func createUser() {
        Task {
           do {
               // Step 1: Create Firebase Account
               try await Auth.auth().createUser(withEmail: email, password: createPassword)
               // Step 2: Updating Profile Photo Info Firebase Storage
               guard let userUID = Auth.auth().currentUser?.uid else { return }
               guard let imageData = userProfilePicData else { return }
               let storageRef = Storage.storage().reference().child("Profile_Image").child(userUID)
               let _ = try await storageRef.putDataAsync(imageData)
               // Step 3: Downloading Photo URL
               let downloadURL = try await storageRef.downloadURL()
               // Step 4: Create a User FireStore Object
               let user = User(username: userName, userUID: userUID, userEmail: email, userProfileURL: downloadURL)
               // Step 5: Saving User Doc info Firestore Database
               let _ = try Firestore.firestore().collection("users").document(userUID).setData(from: user) { error in
                   if error == nil {
                       // Print Saved Successfully
                       print("Saved Successfully")
                       userNameStored = userName
                       self.userUID = userUID
                       profileURL = downloadURL
                       logStatus = true
                   }
               }
           } catch {
               await setError(error)
           }
       }
    }
}

struct CAPage_Previews: PreviewProvider {
    static var previews: some View {
        CAPage()
    }
}
