//
//  Restaurant_Profile.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI

struct Farmer_Profile: View {
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


    var collapsedProfileView: some View {
       
        HStack (spacing: 30){
            Spacer()
            Rectangle()
                .frame(width:75, height: 75)
                .cornerRadius(33)
            VStack{
                Text(farmerName)
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
            Text("Profile Picture:")
                .padding(.leading)
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
            }
        }
    }
    
    var farmDescriptionView: some View{
        VStack(alignment: .leading){
            Text("Farm Description: ")
                .padding(.leading)
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
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading){
                        Group{
                            Spacer(minLength: 20)
                            NavigationLink(destination: EditProfileInfo(isEditingProfileInfo: $isEditingProfileInfo), isActive: $isEditingProfileInfo){
                                collapsedProfileView
                            }
                            Spacer(minLength: 25)
                            Divider()
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
                            HStack
                            {
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
                    
                }
            }
        }
    }
}

struct Farmer_Profile_Previews: PreviewProvider {
    static var previews: some View {
        Farmer_Profile()
    }
}
