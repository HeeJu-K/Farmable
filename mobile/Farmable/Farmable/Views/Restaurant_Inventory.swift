//
//  Farmer_Inventory.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/5/24.
//

import SwiftUI


struct OrderPostRequest: Codable {
    let id: String
    let produceName: String
    let originFarm: String
    let destinationRestaurant: String
    let orderStatus: Int
    let quantity: Int
    let price: Int
    let timestamp: String
    let lastUpdateTime: String
    let restaurantNotes: String
}

struct Restaurant_Inventory: View {
    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let originFarm: String
        let quantity: String
    }
    @State private var itemList = [
        Item(name: "Spinach", originFarm:"HeeJu's Farm", quantity: "50Ibs"),
        Item(name: "Apples", originFarm:"Sean's Farm", quantity: "30Ibs"),
        Item(name: "Lemon", originFarm:"Sean's Farm", quantity: "10Ibs"),
        Item(name: "Squash", originFarm:"Sean's Farm", quantity: "45Ibs"),
        Item(name: "Tomato", originFarm:"HeeJu's Farm", quantity: "80Ibs"),
        Item(name: "Potato", originFarm:"HeeJu's Farm", quantity: "70Ibs"),
    ]
    @State private var responseData: String?
    @State private var errorMessage: String?
    
    @State private var id: String = ""
    @State private var produceName: String = ""
    @State private var originFarm: String = ""
    @State private var test: String = ""
    @State private var destinationRestaurant: String = ""
    @State private var orderStatus: Int = 0
    @State private var quantity: Int = 0
    @State private var price: Int = 0
    @State private var timestamp: String = ""
    @State private var lastUpdateTime: String = ""
    @State private var restaurantNotes: String = ""
    
    @State private var isShowingRequestPopup: Bool = false
    @State private var activeRequestItem: Item?
    
    @State private var isShowingScanner = false //scanner will close when button on popup is pressed
    @State private var isShowingScannedPopup = false // once scanned, the popup will be displayed
    @State private var scannedOrder: OrderRequest?
    
    var RequestView: some View {
        GeometryReader { geometry in
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Text(activeRequestItem?.name ?? "")
                            .font(.largeTitle)
                        HStack{
                            Spacer()
                            Text("Farm:")
                            Text(activeRequestItem?.originFarm ?? "")
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Text("Price:")
                            TextField("Price per Ibs", value: $price, formatter: NumberFormatter())
                            Text(" per Ibs")
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Text("Quantity:")
                            TextField("Quantity", value: $quantity, formatter: NumberFormatter())
                            Text(" Ibs")
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Text("Special Notes to Farmer:")
                            TextField("Please write down notes to farmer if any", text: $restaurantNotes)
                            Spacer()
                        }
                        Button("Request") {
                            let orderRequest = OrderPostRequest(
                                id: id,
                                produceName: activeRequestItem?.name ?? "",
                                originFarm: originFarm,
                                destinationRestaurant: "This Restaurant",
                                orderStatus: orderStatus,
                                quantity: quantity,
                                price: price,
                                timestamp: timestamp,
                                lastUpdateTime: lastUpdateTime,
                                restaurantNotes: restaurantNotes
                            )
                            let request = APIRequest()
                            request.postRequest(requestBody: orderRequest, endpoint: "/order/create") { result in
                                switch result {
                                case .success(let data):
                                    self.responseData = data
                                case .failure(let error):
                                    self.errorMessage = "Error: \(error)"
                                }
                            }
                        }
                            .padding(5)
                            .background(Color.green)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                    }
                    .frame(width: geometry.size.width*0.8, height:geometry.size.height*0.5)
                    .background(Color.white)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack{
                    VStack{
                        Text("Trackable Produce")
                        Spacer()
                        
                        List {
                            ForEach(itemList) { item in
                                HStack{
                                    Text(item.name)
                                        .font(.system(size: 24))
                                    Spacer()
                                    VStack{
                                        Spacer()
                                        Text(item.originFarm)
                                            .font(.system(size: 12))
                                    }
                                    Spacer()
                                    Button("Request"){
                                        self.isShowingRequestPopup = true
                                        self.activeRequestItem = item
                                    }
                                    Image(systemName: "chevron.right")
                                }
                                .frame(height:50)
                            }
                        }
                        
                        HStack{
                            Spacer()
//                            NavigationLink(destination: ScannerViewControllerRepresentable( isShowingScannedPopup: $isShowingScannedPopup, scannedOrder: $scannedOrder), isActive: $isShowingScanner) {
//                                Image(systemName: "qrcode.viewfinder")
//                                    .resizable()
//                                    .frame(width:50, height:50)
//                                    .padding(10)
//                                    .foregroundColor(.white)
//                                    .background(Color.green)
//                                    .cornerRadius(7)
                                
                            Button {isShowingScanner = true}
                            label: {Image(systemName: "qrcode.viewfinder")
                                    .resizable()
                                    .frame(width:50, height:50)
                                    .padding(10)
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                    .cornerRadius(7)}
                          
                                
                            .sheet(isPresented: $isShowingScanner) {
                                ScannerViewControllerRepresentable(isShowingScannedPopup: $isShowingScannedPopup, scannedOrder: $scannedOrder)
                            }
//                            if isShowingScannedPopup, let scannedOrder = scannedOrder {
//                                ScannedInfoPopupView(scannedOrder: scannedOrder, isShowingScanner:$isShowingScanner, isShowingScannedPopup: $isShowingScannedPopup)
//                            }
//                            .sheet(isPresented: $isShowingScannedPopup) {
//                                if let scannedOrder = scannedOrder {
//                                    ScannedInfoPopupView(scannedOrder: scannedOrder, isShowingScanner: $isShowingScanner, isShowingScannedPopup: $isShowingScannedPopup)
//                                } else {
//                                    EmptyView()
//                                }
//                            }
                            Spacer()
                        }
                        Spacer()
                            .frame(height: geometry.size.height*0.1)
                    }
                    if isShowingScannedPopup, let scannedOrder = scannedOrder {
                        ScannedInfoPopupView(scannedOrder: scannedOrder, isShowingScanner:$isShowingScanner, isShowingScannedPopup: $isShowingScannedPopup)
                    }
                    if isShowingRequestPopup {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                isShowingRequestPopup = false
                            }
                        RequestView
                    }
                }
            }
        }
    }
}

struct Restaurant_Inventory_Previews: PreviewProvider {
    static var previews: some View {
        Restaurant_Inventory()
    }
}
