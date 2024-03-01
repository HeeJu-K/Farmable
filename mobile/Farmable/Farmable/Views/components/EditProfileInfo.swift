//
//  ProfileInfo.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/29/24.
//

import SwiftUI

struct EditProfileInfo: View {
    @Binding var isEditingProfileInfo: Bool
    @State private var restaurantName: String = "Stone Burner"
    
    @State private var restaurantAddr = ""

    @State private var image = UIImage()
    @State private var isPhotoPickerPresented = false

    
    var body: some View {
        GeometryReader { geometry in
            
            HStack{
                Spacer()
                VStack{
                    
                    Spacer()
                    ImagePickerView()
                        
                        .frame(width:150, height: 150)
                        .cornerRadius(75)
                    Spacer()
                    Group{
                        Text("Restaurant Name:")
                        TextField("", text:$restaurantName)
                            .padding()
                            .background(Color.green.opacity(0.1).cornerRadius(10))
                            .frame(width:geometry.size.width*0.8)
                    }
                    Spacer()
                    Text("Restaurant Address:")
                    TextField("", text:$restaurantAddr)
                        .padding()
                        .background(Color.green.opacity(0.1).cornerRadius(10))
                        .frame(width:geometry.size.width*0.8)
                    Spacer()
                        Button("save"){isEditingProfileInfo = false}
                        
                }
                .frame(height:geometry.size.height*0.6)
                Spacer()
            }
        }
    }
}

struct EditProfileInfo_Previews: PreviewProvider {
    @State static var isEditingProfileInfo: Bool = true
    static var previews: some View {
        EditProfileInfo(isEditingProfileInfo: $isEditingProfileInfo)
    }
}
