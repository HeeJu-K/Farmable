//
//  EditTeamDescription.swift
//  Farmable
//
//  Created by HeeJu Kim on 3/1/24.
//

import SwiftUI

struct EditTeamDescription: View {
    @Binding var isEditingTeamDescription: Bool
    @State private var teamDescription = ""


    var body: some View {
        GeometryReader { geometry in
            HStack{
                Spacer()
                VStack(alignment: .leading){
                    Spacer(minLength: 50)
                    Text("Personal / Team Description:")
                        .padding(.leading)
                        
                    Spacer()
                        .frame(height:10)
                    Text("Please provide a picture of your team, this picture will be visible to the customers.")
                        .font(.system(size: 13))
                        .foregroundStyle(.gray)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading)
                    
                    ImagePickerView()
                        .frame(height:200)
                    HStack{
                        Spacer()
                        TextField("Enter your description here", text:$teamDescription, axis:.vertical)
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
                        Button("save"){isEditingTeamDescription = false}
                        Spacer()
                    }
                        
                }
                .frame(height:geometry.size.height*0.7)
                Spacer()
            }
        }
    }
}

struct EditTeamDescription_Previews: PreviewProvider {
    
    @State static var isEditingTeamDescription: Bool = true
    static var previews: some View {
        EditTeamDescription(isEditingTeamDescription: $isEditingTeamDescription)
        
    }
}
