//
//  ContentView.swift
//  Farmable
//
//  Created by HeeJu Kim on 1/21/24.
//

import SwiftUI

enum TabSelection: Hashable {
    case farmer
    case restaurant
}

struct LoginPage: View {
    @State private var responseData: String?
    @State private var errorMessage: String?
    
    @State private var username = ""
    @State private var lastName = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var isNavigate = false
    @State private var selectedTab: Int = 0 //0: farmer, 1: restaurant
    private var destinationView: some View {
           switch selectedTab {
               case 0: return AnyView(FarmerView())
               case 1: return AnyView(RestaurantView())
               default: return AnyView(Text("Unknown Destination"))
           }
       }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Color.green
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                VStack{
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    HStack {
                            Button(action: {
                                self.selectedTab = 0
                            }) {
                                Text("Farmer")
                                    .padding()
                                    .background(self.selectedTab == 0 ? Color.green : Color.clear)
                                    .foregroundColor(self.selectedTab == 0 ? .white : .black)
                            }
                            
                            Button(action: {
                                self.selectedTab = 1
                            }) {
                                Text("Restaurant")
                                    .padding()
                                    .background(self.selectedTab == 1 ? Color.green : Color.clear)
                                    .foregroundColor(self.selectedTab == 1 ? .white : .black)
                            }
                        }
                        .cornerRadius(10)
                        .border(.green)
                        
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    TextField("LastName", text: $lastName)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    Button("Login") {
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                    Button("Register") {
                        let newUser = UserInfo(
                            id: "",
                            firstName: "",
                            lastName: lastName,
                            password: password,
                            role: selectedTab == 0 ? "farmer" : "restaurant",
                            isEnabled: false,
                            profileUrl: "url",
                            size: nil,
                            address: nil,
                            name: nil,
                            email: username,
                            teamDescription: nil,
                            locationDescription: nil,
                            farmerFeedback: nil,
                            restaurantFeedback: nil
                        )
                        let postRequest = APIRequest()
                        postRequest.postRequest(requestBody: newUser, endpoint: "/register") { result in
                            switch result {
                            case .success(let data):
                                self.responseData = data
                            case .failure(let error):
                                self.errorMessage = "Error: \(error)"
                            }
                        }
                    }
                    NavigationLink(destination: destinationView, isActive: $isNavigate) {
                        EmptyView()
                    }
                }
            }
            
        }
    }
    func authenticateUser(username: String, password:String) {
        if username.lowercased() == "" {
            wrongUsername = 0
            if password.lowercased() == "" {
                wrongPassword = 0
                isNavigate = true
            } else {
                // set border of the red box as 2
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
