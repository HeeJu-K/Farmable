//
//  ActiveOrder.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/24/24.
//

import SwiftUI

struct ActiveOrder: View {
    let user: String
    let orderRequest: OrderRequest
    internal init(user: String, orderRequest: OrderRequest) {
        self.user = user
        self.orderRequest = orderRequest
    }
    @State private var selectedTab: Int = 0 //0: active order, 1: order history
    @State private var progress: CGFloat = 1

    let status = [
            ["icon": "questionmark.bubble", "text": "Requested"],
            ["icon": "checkmark.circle", "text": "Accepted"],
            ["icon": "leaf", "text": "Harvested"],
            ["icon": "car", "text": "Shipping"],
            ["icon": "bag", "text": "Delivered"]
        ]
    private var progressCnt : CGFloat = 5
    func circleColor(idx:Int) -> Color {
        return orderRequest.orderStatus >= idx ? .green : Color(uiColor: .systemGray5)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Spacer()
                RoundedRectangle(cornerRadius: 20) // Adjust corner radius as needed
                            .stroke(Color.green, lineWidth: 1) // Set border color and width
                            .frame(width: geometry.size.width * 0.95, height: 150)
                            .padding()
//                Rectangle()
//                    .fill(.white)
//                    .border(.green)
//                    .frame(width: geometry.size.width * 0.95, height: 150)
//                    .cornerRadius(20)
//                    .padding()
                VStack{
                    if user == "Restaurant"{
                        Text(orderRequest.originFarm)
                            .frame(alignment: .leading)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                    } else{
                        Text(orderRequest.destinationRestaurant)
                            .frame(alignment: .leading)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                        
                    HStack{
                        Text(orderRequest.produceName)
                            .font(.system(size: 20))
                        Text(String(orderRequest.quantity))
                            .foregroundColor(.green)
                        Text("Ibs")
                            .foregroundColor(.gray)
                        Text("$" + String(orderRequest.price))
                            .foregroundColor(.green)
                        Text("/Ibs")
                            .foregroundColor(.gray)
                    }
//                    Text("Quantity: \(orderRequest.quantity), Price:\(orderRequest.price), Produce: \(orderRequest.produceName)")
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color(uiColor: .systemGray5))
                            .frame(width: geometry.size.width * 0.9, height: 10)
                            .overlay(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 7.0)
                                    .fill(.green)
                                    .foregroundColor(.black)
                                    .frame(width: geometry.size.width * (CGFloat(orderRequest.orderStatus)/progressCnt)+45)
                        }
                        HStack(spacing:27){
                            ForEach(0..<Int(progressCnt), id: \.self) { i in
                                VStack{
                                    ZStack{
                                        Circle()
                                            .fill(circleColor(idx: i))
                                            .frame(width: 50, height: 50)
                                        Image(systemName: status[i]["icon"] ?? "")
                                            .foregroundColor(orderRequest.orderStatus>=i ? .white : .black)
                                    }
                                }
                            }
                        }
                        
                    }
                    HStack(spacing:30){
                        ForEach(0..<Int(progressCnt), id: \.self) { i in
                            Text(status[i]["text"] ?? "Order").font(.system(size: 10))
                        }
                    }
                }
            }
        }
    }
}

struct ActiveOrder_Previews: PreviewProvider {
    static var previews: some View {
        let user = "Farmer"
//        let user = "Restaurant"
        let sampleOrderRequest = OrderRequest(
            id: "", produceName: "Squash", originFarm: "Sarah's Farm", destinationRestaurant: "This Restauarnt", orderStatus: 0, quantity: 2, price: 4, harvestTime: "yesterday", restaurantNotes:"", farmerNotes:"", lastUpdateTime: ""
        )
//        let sampleOrderRequest = OrderRequest()
        ActiveOrder(user: user, orderRequest:sampleOrderRequest)
    }
}
