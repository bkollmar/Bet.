//
//  ProfilePage.swift
//  Bet_Proto
//
//  Created by Ben Kollmar on 4/24/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import PhotosUI
import SDWebImageSwiftUI

struct ProfilePage: View {
    
    @State private var username = ""
    @State private var profilePicture: UIImage? = nil
    @State private var showImagePicker = false
    @State var userProfilePicData: Data?
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("log_status") var logStatus: Bool = false
    @State private var myProfile: User?
    
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                Color.black
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        Text("Profile")
                            .foregroundColor(.white)
                            .padding()
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.bold)

                        Spacer()

                        Image(systemName: "person")
                            .foregroundColor(.white)

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

                        NavigationLink(destination: FriendsPage().navigationBarBackButtonHidden()) {
                            Image(systemName: "person.2")
                                .foregroundColor(.white)
                        }
                        
                    }
            
                    if let myProfile {
                        ReusableProfileContent(user: myProfile)
                    } else{
                        ProgressView()
                    }
                }
                
                VStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 2)
                        .padding()
                    
                    Button(action: logOutUser) {
                        Text("Log Out")
                    }
                    .foregroundColor(.white)
                    .frame(width: 140, height: 30)
                    .background(Color.gray.opacity(0.6))
                    .cornerRadius(10)
                    .padding()
                    
                    Button(action: deleteAccount) {
                        Text("Delete Account")
                    }
                    .foregroundColor(.white)
                    .frame(width: 140, height: 30)
                    .background(Color.gray.opacity(0.6))
                    .cornerRadius(10)
                    .padding()
            }
            .padding(.bottom, 200)
            
        }
            .task {
                if myProfile != nil{return}
                // Inital Fetch
                await fetchUserData()
            }

        }
    }
    
    func fetchUserData() async{
        guard let userUID = Auth.auth().currentUser?.uid else{return}
        guard let user = try? await Firestore.firestore().collection("users").document(userUID).getDocument(as: User.self) else{return}
        await MainActor.run(body: {
            myProfile = user
        })
    }
    
    func editProfilePicture() {
        return
    }
    
    func logOutUser() {
        try? Auth.auth().signOut()
        logStatus = false
    }
    
    func deleteAccount() {
        Task{
            do{
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                // delete Profile image from storage
                let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
                try await reference.delete()
                // delete firestore user doc
                try await Firestore.firestore().collection("users").document(userUID).delete()
                // delete Auth account
                try await Auth.auth().currentUser?.delete()
                logStatus = false
            } catch {
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        let parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[.originalImage] as? UIImage {
//                parent.image = uiImage
//            }
//
//            picker.dismiss(animated: true)
//        }
//    }
//}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
