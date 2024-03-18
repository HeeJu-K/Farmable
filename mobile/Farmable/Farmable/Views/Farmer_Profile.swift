//
//  Restaurant_Profile.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI

struct UserInfo: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let password: String
    let role: String
    let isEnabled: Bool
    let profileUrl: String?
    let size: String?
    let address: String?
    let name: String?
    let email: String
    let teamDescription: String?
    let locationDescription: String?
    let farmerFeedback: String?
    let restaurantFeedback: String?
}

struct Farmer_Profile: View {
    
    @State private var responseData: [UserInfo] = []
    @State private var errorMessage: String?
    
    @State private var farmerName: String = "Sarah-Miller"
    @State private var farmerFirstName: String = "Sarah"
    @State private var farmerLastName: String = "Miller"

    @State private var farmAddr = ""

    @State private var image = UIImage()
    @State private var isFarmImageRetrived = false
    @State private var retrievedImage = UIImage()
    @State private var isPhotoPickerPresented = false

    @State private var isEditingProfileInfo = false
    @State private var isEditingFarmerDescription = false
    @State private var isEditingFarmDescription = false
    @State private var isShowingFeedback = false

    var collapsedProfileView: some View {
       
        HStack (spacing: 30){
            Spacer()
            Rectangle()
                .frame(width:75, height: 75)
                .cornerRadius(33)
            VStack{
                Text(farmerFirstName + " " + farmerLastName)
                    .font(.system(size: 20))
                Text("Address")
            }
            Image(systemName: "chevron.right")
            Spacer()
        }
        .onTapGesture {
            self.isEditingProfileInfo = true
        }
    }
    
    var farmerView: some View{
        VStack(alignment: .leading){
            Spacer(minLength: 20)
            Text("Profile Picture")
                .padding(.leading)
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .foregroundColor(.black)
            Spacer().frame(height:7)
            if !responseData.isEmpty {
                Text(responseData[0].teamDescription ?? "")
                    .font(.system(size: 13))
                    .foregroundStyle(.black)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading)
                    .multilineTextAlignment(.leading)
            }
            Spacer().frame(height:7)
            Text("Please provide a picture and a description of yourself, they will be visible to the customers.")
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 13))
                .foregroundStyle(.gray)
                .padding(.leading)
                .multilineTextAlignment(.leading)
            
            HStack{
                Spacer()
                ImageViewControllerRepresentable(imageName: farmerName+".jpeg")
                Spacer()
            }
                .frame(height: 200)
            HStack{
                Spacer()
                Image(systemName: "chevron.right")
                Spacer().frame(width: 10)
            }
        }
    }
    
    var farmDescriptionView: some View{
        VStack(alignment: .leading){
            Text("Farm Description: ")
                .padding(.leading)
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .foregroundColor(.black)
            Spacer().frame(height:7)
            if !responseData.isEmpty {
                Text(responseData[0].locationDescription ?? "")
                    .font(.system(size: 13))
                    .foregroundStyle(.black)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading)
                    .multilineTextAlignment(.leading)
            }
            Spacer().frame(height:7)
            Text("Please provide a picture and a description of your farm, they will be visible to the customers.")
                .font(.system(size: 13))
                .foregroundStyle(.gray)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading)
                .multilineTextAlignment(.leading)
            Text("eg. Tell us about what you value, featured practices or any other selling point you wish to emphasize.")
                .italic()
                .font(.system(size: 11))
                .foregroundStyle(.gray)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .padding(.leading)
            HStack{
                Spacer()
                ImageViewControllerRepresentable(imageName: "Farm.jpeg")
                Spacer()
            }.frame(height:250)
//            ImagePickerView()
//                .frame(height:200)
//            if isFarmImageRetrived{
//                Image(uiImage: retrievedImage)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 150)
//            }
            HStack{
                Spacer()
                Image(systemName: "chevron.right")
                Spacer().frame(width: 10)
            }
        }
    }
    
    
    var body: some View {
//        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading){
                        Group{
                            Spacer(minLength: 20)
                            NavigationLink(destination: EditProfileInfo(isEditingProfileInfo: $isEditingProfileInfo), isActive: $isEditingProfileInfo){
                                collapsedProfileView
                            }
                            .hidden()
                            Spacer(minLength: 25)
                            Divider()
                        }
                        .onAppear{
                            let request = APIRequest()
                            request.getRequest(endpoint: "/users") { result in
                                DispatchQueue.main.async {
                                    switch result {
                                    case .success(let data):
                                        do {
                                            let responseData = try JSONDecoder().decode([UserInfo].self, from: data)
                                            self.responseData = responseData
                                            
                                        } catch {
                                            print("Error decoding JSON: \(error)")
                                        }
                                    case .failure(let error):
                                        self.errorMessage = "Error: \(error)"
                                    }
                                }
                            }
                        }
                        // feedback section
                        Spacer().frame(height:20)
                        Group{
                            NavigationLink(destination: FeedbackPage(), isActive: $isShowingFeedback){
                                Text("View Feedback")
                                    .padding(.leading)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                HStack{
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    Spacer().frame(width: 10)
                                }
                            }
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                        }
                        Spacer().frame(height:20)
                        HStack{
                            Spacer()
                            VStack{
                                Divider().frame(width:geometry.size.width*0.9)
                            }
                            Spacer()
                        }
                        // fetch farmer profile image
//                        .onAppear {
//                            let request = ImageRequest()
//                            request.getImg(imageName: "\(farmerName).jpeg") { result in
//                                DispatchQueue.main.async {
//                                    switch result {
//                                    case .success(let image):
//                                        self.retrievedImage = image
//                                        self.isFarmImageRetrived = true
//                                    case .failure(let error):
//                                        print("Failed to fetch image:", error)
//                                    }
//                                }
//                            }
//                        }
                        
                        Group{
                            NavigationLink(destination: EditTeamDescription(isEditingTeamDescription: $isEditingFarmerDescription), isActive: $isEditingFarmerDescription){
                                farmerView}
                            Spacer(minLength: 15)
                            HStack{
                                Spacer()
                                VStack{
                                    Divider()
                                        .frame(width:geometry.size.width*0.9)
                                }
                                Spacer()
                            }
                        }
                        
                        Spacer(minLength: 35)
                        Group{
                            NavigationLink(destination: EditRestaurantDescription(isEditingRestaurantDescription: $isEditingFarmDescription), isActive: $isEditingFarmDescription){
                                farmDescriptionView}
                        }
                    }
                    Group{
                        Text("See how your produce is being loved!")
                        HStack{
                            VStack{
                                Text("Number of Love")
                                Text("192")
                            }
                            VStack{
                                Text("Wants to hear more")
                                Text("192")
                            }
                        }
                        if !responseData.isEmpty {
                            Text("Feedback from customers:")
                            Text(responseData[0].farmerFeedback ?? "")
                        } else {
                            Text("No feedback available")
                        }
                    }
                    
                }
            }
        }
//    }
}

struct Farmer_Profile_Previews: PreviewProvider {
    static var previews: some View {
        Farmer_Profile()
    }
}
