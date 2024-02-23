//
//  LoginTab.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI

struct LoginTab: View {
    var body: some View {
//        NavigationView {
//            ZStack {
                TabView(){
                    LoginPage()
                        .tabItem() {
                            Text("Farmer")
                        }
                    LoginPage()
                        .tabItem() {
                            Text("Restaurant")
                        }
                }.frame(minWidth: 300)
//            }
//        }
    }
}

struct LoginTab_Previews: PreviewProvider {
    static var previews: some View {
        LoginTab()
    }
}
