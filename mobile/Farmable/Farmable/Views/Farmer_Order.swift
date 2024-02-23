//
//  Farmer_Order.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI

struct Farmer_Order: View {
    @State private var responseData: Data?
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
                    if let data = responseData {
                        // Display the retrieved data
                        Text(String(data: data, encoding: .utf8) ?? "Data cannot be decoded")
                    } else if let errorMessage = errorMessage {
                        // Display an error message if there's an error
                        Text(errorMessage)
                    } else {
                        // Display a placeholder or loading indicator while data is being retrieved
                        ProgressView()
                    }
                }
                .onAppear {
                    let request = APIRequest()
                    request.getRequest(endpoint: "/farm") { result in
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

struct Farmer_Order_Previews: PreviewProvider {
    static var previews: some View {
        Farmer_Order()
    }
}
