//
//  Restaurant_Profile.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI

struct Restaurant_Order: View {
    @State private var selectedTab: Int = 0 //0: farmer, 1: restaurant
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
    var body: some View {
        
            GeometryReader { geometry in
                ZStack {
                    VStack{
                        ZStack{
                            Spacer()
                            Rectangle()
                                .fill(.green.opacity(0.5))
                                .frame(width: geometry.size.width * 0.95, height: 150)
                                .cornerRadius(20)
                                .padding()
                            VStack{
                                Text("Farm A").frame(alignment: .leading)
                                Text("Quantity: 50Ibs, Price:")
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .fill(Color(uiColor: .systemGray5))
                                        .frame(width: geometry.size.width * 0.9, height: 20)
                                        .overlay(alignment: .leading) {
                                            RoundedRectangle(cornerRadius: 7.0)
                                                .fill(.green)
                                                .frame(width: geometry.size.width * (progress/progressCnt)+45)
                                        }
                                    HStack(spacing:27){
                                        ForEach(0..<Int(progressCnt), id: \.self) { i in
                                            VStack{
                                                ZStack{
                                                    Circle()
                                                        .fill(circleColor(idx: i))
                                                        .frame(width: 50, height: 50)
                                                    Image(systemName: status[i]["icon"] ?? "")
                                                }
                                                //                                                Text(status[i]["text"] ?? "Order").font(.system(size: 10))
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
            
        }
    
}

struct Restaurant_Order_Previews: PreviewProvider {
    static var previews: some View {
        Restaurant_Order()
    }
}
