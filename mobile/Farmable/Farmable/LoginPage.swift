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
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var selectedTab: Int = 0 //0: farmer, 1: restaurant
    
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
                    Button("Login") {
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                    
//                    NavigationLink(destination: NavbarView()) {
//                        EmptyView()
//                    }
                                    
                    // Conditional navigation links based on selected tab
                    NavigationLink(value: TabSelection.farmer) {
                        EmptyView()
                    }
                    NavigationLink(value: TabSelection.restaurant) {
                        EmptyView()
                    }
                }
                .navigationDestination(for: TabSelection.self) { tab in
                                // Determine which view to navigate to based on the selection.
                    switch tab {
                    case .farmer:
                        Farmer_Order()
                    case .restaurant:
                        Restaurant_Inventory()
                    }
                }
                .navigationTitle("Custom Tabs")
                // This triggers the navigation programmatically.
                .onChange(of: selectedTab) { _ in
                    // This block intentionally left blank.
                    // Navigation is triggered by the change of selectedTab's value.
                }
            }
            
        }
    }
    func authenticateUser(username: String, password:String) {
        if username.lowercased() == "" {
            wrongUsername = 0
            if password.lowercased() == "" {
                wrongPassword = 0
                showingLoginScreen = true
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
