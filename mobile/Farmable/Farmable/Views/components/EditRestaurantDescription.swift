//
//  EditRestaurantDescription.swift
//  Farmable
//
//  Created by HeeJu Kim on 3/1/24.
//

import SwiftUI

struct EditRestaurantDescription: View {
    @Binding var isEditingRestaurantDescription: Bool
    
    @State private var restaurantDescription = ""

    var body: some View {
        GeometryReader { geometry in
            HStack{
                Spacer()
                VStack(alignment: .leading){
                    Spacer(minLength: 50)
                    Text("Restaurant Description:")
                        .padding(.leading)
                        
                    Spacer()
                        .frame(height:10)
                    Text("Please provide a picture and a description to your restaurant, this will be visible to the customers.")
                        .font(.system(size: 13))
                        .foregroundStyle(.gray)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading)
                    Text("eg. Tell us about the values of your team, or any selling point you wish to emphasize.")
                        .italic()
                        .font(.system(size: 11))
                        .foregroundStyle(.gray)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading)
                    ImagePickerView()
                        .frame(height:200)
                    HStack{
                        Spacer()
                        TextField("Enter your description here", text:$restaurantDescription, axis:.vertical)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(5...10)
                            .padding()
                            .frame(width:geometry.size.width*0.9)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 20)
                    HStack{
                        Spacer()
                        Button("save"){isEditingRestaurantDescription = false}
                        Spacer()
                    }
                        
                }
                .frame(height:geometry.size.height*0.8)
                Spacer()
            }
        }
    }
}

struct EditRestaurantDescription_Previews: PreviewProvider {
    
    @State static var isEditingRestaurantDescription: Bool = true
    static var previews: some View {
        EditRestaurantDescription(isEditingRestaurantDescription: $isEditingRestaurantDescription)
        
    }
}
