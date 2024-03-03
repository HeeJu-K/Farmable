//
//  Restaurant_Profile.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI
struct OrderRequest: Codable {
    let id: String
    let produceName: String
    let originFarm: String
    let destinationRestaurant: String
    let orderStatus: Int
    let quantity: Int
    let price: Int
    let harvestTime: String?
    let restaurantNotes: String?
    let farmerNotes: String?
    let lastUpdateTime: String?
}

struct Restaurant_Order: View {
    @State private var selectedTab: Int = 0 //0: active order, 1: order history
    @State private var progress: CGFloat = 1
    // 0: Requested, 1:Accepted, 2:Harvested, 3: On Delivery, 4:Delivered
    let status = [
        ["icon": "questionmark.bubble", "text": "Requested"],
        ["icon": "checkmark.circle", "text": "Accepted"],
        ["icon": "leaf", "text": "Harvested"],
        ["icon": "car", "text": "Shipping"],
        ["icon": "bag", "text": "Delivered"]
    ]
    private var progressCnt : CGFloat = 5
    func circleColor(idx:Int) -> Color {
        return Int(progress) >= idx ? .green : Color(uiColor: .systemGray5)
    }
    
    @State private var responseData: [OrderRequest] = []
    @State private var errorMessage: String?
    var body: some View {
        
            GeometryReader { geometry in
                ZStack {
                    VStack{
                        HStack {
                            Button(action: {
                                self.selectedTab = 0
                            }) {
                                Text("Active Order")
                                    .padding()
                                    .background(self.selectedTab == 0 ? Color.green : Color.clear)
                                    .foregroundColor(self.selectedTab == 0 ? .white : .black)
                            }
                            
                            Button(action: {
                                self.selectedTab = 1
                            }) {
                            Text("Order History")
                                .padding()
                                .background(self.selectedTab == 1 ? Color.green : Color.clear)
                                .foregroundColor(self.selectedTab == 1 ? .white : .black)
                            }
                        }
                        .cornerRadius(10)
                        .border(.green)
//                        ScrollView {
                            //display active order view
                            if selectedTab == 0 {
                                VStack(spacing:150){
                                    if !responseData.isEmpty {
                                        
                                        ForEach(responseData, id: \.id) { orderRequest in
                                            if orderRequest.orderStatus < 6 {
                                                ActiveOrder(orderRequest: orderRequest)
                                            }
                                        }
                                        
                                    } else {
                                        Text("Data is loading...")
                                    }
                                }
                                
                            }
//                        }
                        ScrollView {
                            //display completed order view
                            if selectedTab == 1{
                                VStack{
                                    if !responseData.isEmpty {
                                        ForEach(responseData, id: \.id) { orderRequest in
                                            if orderRequest.orderStatus >= 4 {
                                                FinishedOrder(orderRequest: orderRequest)
                                            }
                                        }
                                        
                                    } else {
                                        Text("Data is loading...")
                                    }
                                }
                            }
                            
                        }
                        //fetch data
                        .onAppear {
                            let request = APIRequest()
                            request.getRequest(endpoint: "/order") { result in
                                switch result {
                                case .success(let data):
                                    do {
                                        let responseData = try JSONDecoder().decode([OrderRequest].self, from: data)
                                        self.responseData = responseData
                                    } catch {
                                        print("Error decoding JSON: \(error)")
                                    }
                                case .failure(let error):
                                    self.errorMessage = "Error: \(error)"
                                }
                            }
                        }
                        
                    }
                    
                }
            }
            
        }
    
}

struct Restaurant_Order_Previews: PreviewProvider {
    static var previews: some View {
        Restaurant_Order()
    }
}
