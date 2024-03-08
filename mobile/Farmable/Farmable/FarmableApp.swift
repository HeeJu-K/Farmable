//
//  FarmableApp.swift
//  Farmable
//
//  Created by HeeJu Kim on 1/21/24.
//

import SwiftUI

@main
struct FarmableApp: App {
    init() {
            // Change the appearance of the navigation bar
        UINavigationBar.appearance().barTintColor = UIColor(Color.green) // Set color
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white] // Set title text color
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Set large title text color
        }
    var body: some Scene {
        WindowGroup {
            LoginPage()
        }
    }
}
