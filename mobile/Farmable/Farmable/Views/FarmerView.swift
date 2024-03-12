//
//  NavbarView.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI

struct FarmerView: View {
    var body: some View {
        TabView {
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
        }.accentColor(Color.green)
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        FarmerView()
    }
}
