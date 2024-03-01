//
//  Restaurant_Profile.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI

struct Restaurant_Profile: View {
    @State private var restaurantName: String = "Stone Burner"
    
    @State private var restaurantAddr = ""
    @State private var newRestaurantAddr = ""

    @State private var image = UIImage()
    @State private var isPhotoPickerPresented = false

    @State private var isEditingProfileInfo = false
    @State private var isEditingTeamDescription = false
    @State private var isEditingRestaurantDescription = false


    var collapsedProfileView: some View {
       
        HStack (spacing: 30){
            Spacer()
            Rectangle()
                .frame(width:75, height: 75)
                .cornerRadius(33)
            VStack{
                Text("Stone Buner")
                    .font(.system(size: 20) )
                Text("Address")
            }
            Image(systemName: "chevron.right")
            Spacer()
        }
        .onTapGesture {
            self.isEditingProfileInfo = true
        }
    }
    
    var restaurantTeamView: some View{
        VStack(alignment: .leading){
            Spacer(minLength: 20)
            Text("Restaurant Team:")
                .padding(.leading)
            Text("Please provide a picture of your team, this picture will be visible to the customers.")
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 13))
                .foregroundStyle(.gray)
                .padding(.leading)
                .multilineTextAlignment(.leading)
            
            ImagePickerView()
                .frame(height:200)
            HStack{
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
    }
    
    var restaurantDescriptionView: some View{
        VStack(alignment: .leading){
            Text("Restaurant Description: ")
                .padding(.leading)
            Text("Please provide a picture and a description to your restaurant, this will be visible to the customers.")
                .font(.system(size: 13))
                .foregroundStyle(.gray)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading)
                .multilineTextAlignment(.leading)
            Text("eg. Tell us about the values of your team, or any selling point you wish to emphasize.")
                .italic()
                .font(.system(size: 11))
                .foregroundStyle(.gray)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .padding(.leading)
            ImagePickerView()
                .frame(height:200)
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
                        
                        Group{
                            NavigationLink(destination: EditTeamDescription(isEditingTeamDescription: $isEditingTeamDescription), isActive: $isEditingTeamDescription){
                            restaurantTeamView}
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
                            NavigationLink(destination: EditRestaurantDescription(isEditingRestaurantDescription: $isEditingRestaurantDescription), isActive: $isEditingRestaurantDescription){
                                restaurantDescriptionView}
                        }
                    }
                }
            }
        }
    }
}

struct Restaurant_Profile_Previews: PreviewProvider {
    static var previews: some View {
        Restaurant_Profile()
    }
}
