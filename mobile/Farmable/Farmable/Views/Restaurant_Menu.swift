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
                    Button(action: {
                        self.showingAddItem = true
                    }) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .foregroundColor(.green)
                            .frame(width: 40, height: 40)
                            .scaledToFit()
                    }
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
                
                Spacer().frame(height:15)
                Text(dishItem.dishName)
                    .fontWeight(.semibold)
                    .font(.system(size: 28))
                Spacer().frame(height:10)
                Group{
                    Text("$"+String(dishItem.price))
    //                    .fontWeight(.semibold)
                        .font(.system(size: 20))
                    Spacer().frame(height:10)
                    Text(dishItem.description)
                        .font(.system(size: 16))
                    Spacer().frame(height:10)
                    Toggle("Active?", isOn: $isActive)
                    Spacer().frame(height:10)
                    HStack{
                        Text("Menu Type")
                        Spacer()
                        DropdownView(selectedMenuType: $menuType)
                            .frame(width: geometry.size.width*0.6)
                    }
                    Spacer().frame(height:10)
                }
                Spacer().frame(height:60)
                Button("close") {
                }
                    .frame(width: 75, height:40)
                    .background(Color.green)
                    .cornerRadius(10)
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
                HStack{
                    VStack(alignment: .leading){
                        Text("Dish Name")
                            .frame(height:50)
                        Text("Price").frame(height:50)
                        Text("Description").frame(height:50)
                        Text("Active?").frame(height:50)
                        Text("Special?").frame(height:50)
                    }.frame(width: geometry.size.width*0.3)
                    VStack{
                        TextField("Enter dish name", text:$dishName).frame(height:50)
                        TextField("Enter price", text:$price).frame(height:50)
                        TextField("Enter dish description", text:$dishDescription).frame(height:50)
                        Toggle("", isOn: $isActive).frame(height:50)
                        Toggle("", isOn: $isSpecial).frame(height:50)
                        
                    }.frame(width: geometry.size.width*0.7)
                }
                HStack{
                    Text("Menu Type")
                    Spacer()
                    DropdownView(selectedMenuType: $menuType)
                        .frame(width: geometry.size.width*0.6)
                }
                Button("add") {
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
                .frame(width: 75, height:40)
                .background(Color.green)
                .cornerRadius(10)
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
                    .padding(5)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black))
                ForEach(menuTypes, id:\.self) {menuType in
                    Button(menuType) {selectedMenuType = menuType}
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 8)
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
