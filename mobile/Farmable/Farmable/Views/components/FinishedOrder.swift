//
//  FinishedOrder.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/25/24.
//

import SwiftUI

struct FinishedOrder: View {
    let orderRequest: OrderRequest
    internal init(orderRequest: OrderRequest) {
            self.orderRequest = orderRequest
        }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Spacer()
                
                RoundedRectangle(cornerRadius: 20)
                   .fill(Color.white)
                   .frame(width: geometry.size.width * 0.95, height: 150)
                   .overlay(
                       RoundedRectangle(cornerRadius: 25)
                           .stroke(Color.green, lineWidth: 4)
                   )
                   .clipShape(RoundedRectangle(cornerRadius: 25))
                   .position(x: geometry.size.width*0.5, y: 75)
                
                let columns: [GridItem] = [
                    GridItem(.flexible(minimum: geometry.size.width*0.4)), // First column
                    GridItem(.flexible()), // Second column
                    GridItem(.flexible())  // Third column
                ]
                LazyVGrid(columns: columns) {
                    VStack {
                        Text("Produce Name ")
                            .font(.headline)
                        Text("Origin Farm")
                            .font(.subheadline)
                        Text("Price")
                            .font(.subheadline)
                    }
                    VStack {
                        Text("Feb 23rd")
                            .font(.subheadline)
                        Text("OrderStatus")
                            .font(.subheadline)
                    }
                    VStack {
                        Button(action: {}){Text("View")}
                    }
                }
                .padding() // Add padding around the entire grid
                .position(x: geometry.size.width*0.5, y: 75)
                        
            }
        }
    }
}

struct FinishedOrder_Previews: PreviewProvider {
    static var previews: some View {
        let sampleOrderRequest = OrderRequest(
        id: "", originFarm: "", destinationRestaurant: "", orderStatus: 0, quantity: 0, price: 0, timestamp: "", lastUpdateTime: ""
        )
        FinishedOrder(orderRequest:sampleOrderRequest)
    }
}
