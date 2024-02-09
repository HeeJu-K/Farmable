//
//  NavbarView.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI

struct NavbarView: View {
    var body: some View {
        TabView {
            Farmer_Inventory()
                .tabItem() {
                    Image(systemName: "archivebox")
                    Text("Inventory")
                }
            Farmer_Order()
                .tabItem() {
                    Image(systemName: "shippingbox")
                    Text("Order")
                }
            Farmer_Profile()
                .tabItem() {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
