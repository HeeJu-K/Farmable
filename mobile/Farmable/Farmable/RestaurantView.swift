//
//  NavbarView.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI

struct RestaurantView: View {
    var body: some View {
        TabView {
            Restaurant_Inventory()
                .tabItem() {
                    Image(systemName: "archivebox")
                    Text("Inventory")
                }
            Restaurant_Order()
                .tabItem() {
                    Image(systemName: "shippingbox")
                    Text("Order")
                }
            Restaurant_Menu()
                .tabItem() {
                    Image(systemName: "menucard")
                    Text("Menu")
                }
            Restaurant_Profile()
                .tabItem() {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }.accentColor(Color.green)
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView()
    }
}
