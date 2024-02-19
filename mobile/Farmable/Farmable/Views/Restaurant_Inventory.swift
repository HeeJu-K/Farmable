//
//  Farmer_Inventory.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI

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
    var body: some View {
        VStack{
            Text("Trackable Produce")
            List {
                ForEach(itemList) { item in
                    Text(item.name) // Directly access the `name` property
                }
            }
            
        }
    }
}

struct Restaurant_Inventory_Previews: PreviewProvider {
    static var previews: some View {
        Restaurant_Inventory()
    }
}
