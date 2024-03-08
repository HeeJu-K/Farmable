//
//  RestaurantMenu.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/9/24.
//

import SwiftUI

struct DishItem: Codable {
    let id: String
    let dishName: String
    let restaurantName: String
    let description: String
    let price: Int
    let menuType: String
    let active: Bool
    let featured: Bool
}

var menu: [DishItem] = [
    DishItem(
        id: "fec9935e-de5a-4c6b-a07f-2a290f498b35",
        dishName: "Burrata",
        restaurantName: "Stone Burner",
        description: "inion marmellata / flatbread",
        price: 16,
        menuType: "Entree",
        active: true,
        featured: false
    ),
    DishItem(
        id: "662149f9-1495-465c-bf2f-f143a0e3ebd7",
        dishName: "BPC Chop Salad",
        restaurantName: "Ethan Stowell",
        description: "romaine, salami, provolone, taggiasca olives, grape tomatoes, pickled peppers, red onion",
        price: 16,
        menuType: "Salads",
        active: true,
        featured: false
    ),
    DishItem(
        id: "7675bb2c-b9ff-4573-8ffc-fe5a1c04e5b2",
        dishName: "Pizza",
        restaurantName: "Stone Burner",
        description: "inion marmellata / flatbread",
        price: 16,
        menuType: "Small Plates",
        active: true,
        featured: false
    ),
    DishItem(
        id: "7675bb2c-b9ff-4573-8ffc-fe5a1c04e5b2",
        dishName: "Mushroom Pizza",
        restaurantName: "Stone Burner",
        description: "inion marmellata / flatbread",
        price: 25,
        menuType: "Pizza",
        active: true,
        featured: false
    )
]

var menuTypes: [String] {
    let types = Set(menu.map { $0.menuType })
    return types.sorted()
}



struct Restaurant_Menu: View {
    
    
    var menuByTypes: [String: [DishItem]] {
        Dictionary(grouping: menuList) { $0.menuType }
    }
    @State private var menuList: [DishItem] = []

    @State private var responseData: String?
    @State private var errorMessage: String?
    
    @State private var showingPopUp = false
    @State private var selectedItem: DishItem?
    @State private var showingAddItem = false

    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Text("Menu")
                    .onAppear{
                        let request = APIRequest()
                        request.getRequest(endpoint: "/restaurant/menu") { result in
                            switch result {
                            case .success(let data):
                                do {
                                    let responseData = try JSONDecoder().decode([DishItem].self, from: data)
                                    self.menuList = responseData
                                } catch {
                                    print("Error decoding JSON: \(error)")
                                }
                            case .failure(let error):
                                self.errorMessage = "Error: \(error)"
                            }
                        }
                    }
                ZStack{
                    //list view
                    List {
                        ForEach(menuTypes, id:\.self) {menuType in
                            Section(menuType) {
                                if let menuItems = menuByTypes[menuType]{
                                    ForEach(menuItems, id:\.id) {menuItem in
                                        VStack{
                                            HStack{
                                                Text(menuItem.dishName)
                                                Text(String(menuItem.price))
                                            }.onTapGesture {
                                                self.selectedItem = menuItem
                                                self.showingPopUp = true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    // Add button
                    Button("+") {
                        self.showingAddItem = true
                    }
                        .frame(width: 40, height: 40)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .position(x: geometry.size.width - 50, y: geometry.size.height - 80)
                    // modal view
                    if showingPopUp {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                showingPopUp = false
                            }
                        if let selectedItem = selectedItem {
                            PopUpView(dishItem: selectedItem)
                                .frame(width:geometry.size.width*0.8, height:geometry.size.height*0.6)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(radius: 20)
                                .transition(.scale)
                        }
                    }
                    if showingAddItem {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                showingAddItem = false
                            }
                        AddItemPopUpView()
                            .padding()
                            .frame(width:geometry.size.width*0.8, height:geometry.size.height*0.6)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 20)
                            .transition(.scale)
                    }
                }
            }
        }
    }
    
}

struct PopUpView: View {
    var dishItem: DishItem
    
    @State private var isActive = true
    @State private var menuType = ""

    var body: some View {
        GeometryReader { geometry in
            VStack{
                Text(dishItem.dishName)
                Text(String(dishItem.price))
                Text(dishItem.description)
                Toggle("Active?", isOn: $isActive)
                HStack{
                    Text("Menu Type")
                    Spacer()
                    DropdownView(selectedMenuType: $menuType)
                        .frame(width: geometry.size.width*0.6)
                }
                Button("save") {
                }
                    .padding(5)
                    .background(Color.green)
                    .cornerRadius(5)
                    .foregroundColor(.white)
            }
        }
    }
}

struct AddItemPopUpView: View {
    @State private var responseData: String?
    @State private var errorMessage: String?
    
    @State private var isActive = true
    @State private var isSpecial = false
    @State private var dishName = ""
    @State private var price = ""
    @State private var dishDescription = ""
    @State private var menuType = ""

    var body: some View {
        GeometryReader { geometry in
            VStack{
                TextField("Enter dish name", text:$dishName)
                TextField("Enter price", text:$price)
                TextField("Enter dish description", text:$dishDescription)
                Toggle("Active?", isOn: $isActive)
                Toggle("Special?", isOn: $isSpecial)
                HStack{
                    Text("Menu Type")
                    Spacer()
                    DropdownView(selectedMenuType: $menuType)
                        .frame(width: geometry.size.width*0.6)
                    
                }
                Button("save") {
                    let newDishItem = DishItem(
                        id: "",
                        dishName: dishName,
                        restaurantName: "",
                        description: dishDescription,
                        price: Int(price) ?? 0,
                        menuType: menuType,
                        active: isActive,
                        featured: isSpecial
                    )
                    let postRequest = APIRequest()
                    postRequest.postRequest(requestType:"POST", requestBody: newDishItem, endpoint: "/restaurant/menu/add") { result in
                        switch result {
                        case .success(let data):
                            self.responseData = data
                        case .failure(let error):
                            self.errorMessage = "Error: \(error)"
                        }
                    }
                }
                    .padding(5)
                    .background(Color.green)
                    .cornerRadius(5)
                    .foregroundColor(.white)
            }
        }
    }
}

struct DropdownView: View {
    @Binding var selectedMenuType: String
    @State private var newOption: String = ""
    @State private var showTextField: Bool = false

    var body: some View {
        ScrollView (.horizontal) {
            HStack{
                Button("Create") {}
                    .padding(2)
                    .cornerRadius(2)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                ForEach(menuTypes, id:\.self) {menuType in
                    Button(menuType) {selectedMenuType = menuType}
                        .padding(2)
                        .overlay(RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.green))
                }
            }
        }
    }
}

struct Restaurant_Menu_Previews: PreviewProvider {
    static var previews: some View {
        Restaurant_Menu()
    }
}
