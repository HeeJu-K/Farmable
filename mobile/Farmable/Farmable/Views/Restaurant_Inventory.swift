//
//  Farmer_Inventory.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI


struct OrderPostRequest: Codable {
    let id: String
    let originFarm: String
    let destinationRestaurant: String
    let orderStatus: Int
    let quantity: Int
    let price: Int
    let timestamp: String
    let lastUpdateTime: String
}

struct Restaurant_Inventory: View {
    struct Item: Identifiable {
        let id = UUID() // Provides a unique identifier for each item
        let name: String
        let quantity: String
    }
    @State private var itemList = [
        Item(name: "Spinach", quantity: "50Ibs"),
        Item(name: "Apples", quantity: "30Ibs"),
        Item(name: "Lemon", quantity: "10Ibs"),
        Item(name: "Squash", quantity: "45Ibs"),
    ]
    @State private var responseData: String?
    @State private var errorMessage: String?
    
    @State private var id: String = ""
    @State private var originFarm: String = ""
    @State private var test: String = ""
    @State private var destinationRestaurant: String = ""
    @State private var orderStatus: Int = 0
    @State private var quantity: Int = 0
    @State private var price: Int = 0
    @State private var timestamp: String = ""
    @State private var lastUpdateTime: String = ""
    
    var body: some View {
        VStack{
            Text("Trackable Produce")
            List {
                ForEach(itemList) { item in
                    HStack{
                        Text(item.name) // Directly access the `name` property
                        Button("Request"){
                            print("hello")
                            let orderRequest = OrderPostRequest(
                                                id: id,
                                                originFarm: originFarm,
                                                destinationRestaurant: "This Restaurant",
                                                orderStatus: orderStatus,
                                                quantity: quantity,
                                                price: 300,
                                                timestamp: timestamp,
                                                lastUpdateTime: lastUpdateTime
                                            )
                            let request = APIRequest()
                            request.postRequest(requestBody: orderRequest, endpoint: "/order/create") { result in
                                switch result {
                                case .success(let data):
                                    self.responseData = data
                                case .failure(let error):
                                    self.errorMessage = "Error: \(error)"
                                }
                            }
                        }
                    }
                }
            }
            TextField("Test", text: $test)
            TextField("Origin Farm", text: $originFarm)
            TextField("Quantity", value: $quantity, formatter: NumberFormatter())
        
        }
        
    }
}

struct Restaurant_Inventory_Previews: PreviewProvider {
    static var previews: some View {
        Restaurant_Inventory()
    }
}
