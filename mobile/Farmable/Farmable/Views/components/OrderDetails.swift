//
//  OrderDetails.swift
//  Farmable
//
//  Created by HeeJu Kim on 3/1/24.
//

import SwiftUI

struct AddHarvestTimeRequest: Codable {
    let id: String
    let farmerNotes: String?
    let destinationRestaurant: String
}

struct UpdateOrderStatusRequest: Codable {
    let id: String
    let destinationRestaurant: String
    let orderStatus: Int
}

func generateQRCode(from dictionary: OrderRequest) -> UIImage? {
    do {
        let data = try JSONEncoder().encode(dictionary)
        print("qr data", data)
        if let validData = String(data: data,encoding: .utf8){
            print("qr data", validData)
        }

        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            guard let ciImage = filter.outputImage?.transformed(by: transform) else {
                return nil
            }
            // Convert CIImage to CGImage
            let context = CIContext()
            guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
                return nil
            }

            return UIImage(cgImage: cgImage)
        }
    } catch {
        print(error.localizedDescription)
    }
    return nil
}


struct QRCodeView: View {
    
    var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
        } else {
            Text("Failed to generate QR Code")
        }
    }
}

struct OrderDetails: View {
    var orderRequest: OrderRequest
    init(orderRequest: OrderRequest) {
        self.orderRequest = orderRequest
        _updatedOrder = State(initialValue: orderRequest)
    }
    
    @State private var farmerNotes: String = ""
    @State private var showQRCode: Bool = false
    @State private var updatedOrder: OrderRequest

    
    @State private var responseData: String?
    @State private var errorMessage: String?

    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Text("Order Details")
//                    .font(.title)
                    .navigationTitle("Title")
                    .foregroundColor(.green)
                Spacer()
            }
            Spacer().frame(height:100)
            HStack{
                Spacer()
                    .frame(width: 40)
                Group{
                    VStack (alignment: .leading){
                        
                        Text(orderRequest.produceName)
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                        Spacer()
                            .frame(height: 20)
                        HStack{
                            Text("Order from ")
                                .foregroundColor(.gray)
                            Text(orderRequest.destinationRestaurant)
                                .font(.system(size: 20))
                        }
                        Spacer()
                            .frame(height: 10)
                        HStack{
//                            Spacer()
//                                .frame(width: 30)
                            VStack (alignment: .leading){
                                Text("Price: ")
                                    .foregroundColor(.gray)
                                Text("$"+String(orderRequest.price)+" / Ibs")
                            }
                            Spacer()
                            VStack (alignment: .leading){
                                Text("Quantity: ")
                                    .foregroundColor(.gray)
                                Text(String(orderRequest.quantity)+" Ibs")
                            }
                            Spacer()
                        }
                        Spacer()
                            .frame(height: 15)
                        Group{
                            Text("Notes from restaurant owners: ")
                                .foregroundColor(.gray)
                            if orderRequest.restaurantNotes != ""{
                                Text(orderRequest.restaurantNotes ?? "")
                            } else {
                                Text("There were no specific instructions from the restaurant.")
                                    .font(.system(size:12))
                            }
                        }
                    }
                }
                Spacer()
                    .frame(width: 40)
            }
            //for order before accept
            if orderRequest.orderStatus == 0{
                Group{
                    Spacer()
                        .frame(height: 50)
                    HStack{
                        Spacer()
                        HStack {
                            Button(action: {
                                let updateOrderStatusRequest = UpdateOrderStatusRequest(
                                    id: orderRequest.id,
                                    destinationRestaurant: orderRequest.destinationRestaurant,
                                    orderStatus: 1 // Accepted
                                )
                                let request = APIRequest()
                                request.postRequest(requestType:"PUT", requestBody: updateOrderStatusRequest, endpoint: "/order/update") { result in
                                    switch result {
                                    case .success(let data):
                                        self.responseData = data
                                    case .failure(let error):
                                        self.errorMessage = "Error: \(error)"
                                    }
                                }
                                
                            }) {
                            Label("Accept", systemImage: "checkmark")
                              .padding(10)
                              .foregroundColor(.white)
                              .background(Color.green)
                              .cornerRadius(7)
                          }
                        }
                        Spacer()
                        Button(action: {}) {
                            Label("Decline", systemImage: "xmark")
                                .padding(10)
                                .foregroundColor(.green)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.green, lineWidth: 2)
                                )
                        }
                        Spacer()
                    }
                }
            }
            // for accepted order to be harvested
            if orderRequest.orderStatus==1{
                Spacer()
                    .frame(height:20)
                HStack{
                    Spacer()
                        .frame(width: 40)
                    
                    VStack(alignment: .leading){
                        
                        Text("Notes for Restaurant:")
                            .foregroundColor(.gray)
                        TextField("Add notes here", text:$farmerNotes)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        Text("Please provide details of your farming practices. This is not required but will help restaurants and customers better understand values of your produces.")
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.system(size: 13))
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.leading)
                        Spacer()
                            .frame(height:20)
                        HStack{
                            Spacer()
                            Button(action: {
                                self.showQRCode = true
                                let addHarvestTimeRequest = AddHarvestTimeRequest(
                                    id: orderRequest.id,
                                    farmerNotes: farmerNotes,
                                    destinationRestaurant: orderRequest.destinationRestaurant
                                )
                                let request = APIRequest()
                                request.postRequest(requestType:"PUT", requestBody: addHarvestTimeRequest, endpoint: "/order/harvest") { result in
                                    switch result {
                                    case .success(let data):
                                        self.responseData = data
                                        self.showQRCode = true
                                    case .failure(let error):
                                        self.errorMessage = "Error: \(error)"
                                    }
                                }
                                updatedOrder = OrderRequest(
                                    id: orderRequest.id,
                                    produceName:orderRequest.produceName,
                                    originFarm: orderRequest.originFarm,
                                    destinationRestaurant: orderRequest.destinationRestaurant,
                                    orderStatus: orderRequest.orderStatus,
                                    quantity: orderRequest.quantity,
                                    price: orderRequest.price,
                                    harvestTime: String(Date().timeIntervalSince1970 * 1000),
                                    restaurantNotes: orderRequest.restaurantNotes,
                                    farmerNotes: farmerNotes,
                                    lastUpdateTime:"Current time"
                                )
                            }) {
                                if !showQRCode{
                                    Label("Generate QR Code", systemImage: "qrcode")
                                        .padding(10)
                                        .foregroundColor(.white)
                                        .background(Color.green)
                                        .cornerRadius(7)
                                } else {
                                    VStack{
                                        Text("Print out your QRCode!")
                                        Spacer()
                                            .frame(height:20)
                                        HStack{
                                            Spacer()
                                            QRCodeView(image: generateQRCode(from: updatedOrder))
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
//                        if showQRCode {
//                            Spacer()
//                                .frame(height:20)
//                            HStack{
//                                Spacer()
//                                QRCodeView(image: generateQRCode(from: updatedOrder))
//                                Spacer()
//                            }
//                        }
                    }
                    Spacer()
                        .frame(width: 40)
                }
            }
            // for harvested order shipped
            if orderRequest.orderStatus == 2 {
                Spacer()
                    .frame(height:20)
                HStack{
                    Spacer()
                    Button(action: {
                        let updateOrderStatusRequest = UpdateOrderStatusRequest(
                            id: orderRequest.id,
                            destinationRestaurant: orderRequest.destinationRestaurant,
                            orderStatus: 3 // Delivered
                        )
                        let request = APIRequest()
                        request.postRequest(requestType:"PUT", requestBody: updateOrderStatusRequest, endpoint: "/order/update") { result in
                            switch result {
                            case .success(let data):
                                self.responseData = data
                            case .failure(let error):
                                self.errorMessage = "Error: \(error)"
                            }
                        }
                    }) {
                    Label("Shipped", systemImage: "bag")
                      .padding(10)
                      .foregroundColor(.white)
                      .background(Color.green)
                      .cornerRadius(7)
                    }
                    Spacer()
                }
            }
            // for shipped order
            if orderRequest.orderStatus == 3 {
                Spacer()
                    .frame(height:20)
                HStack{
                    Spacer()
                        .frame(width: 40)
                    Text("This order is on delivery.\nWait for restaurant to confirm your delivery.")
                        .foregroundColor(.green)
                    Spacer()
                        .frame(width: 40)
                }
            }
            Spacer()
        }
    }
}


struct OrderDetails_Previews: PreviewProvider {
    @State static var isShowingOrderDetails: Bool = true
    static var previews: some View {
        
        let sampleOrderRequest = OrderRequest(
            id: "fwefqwa", produceName: "Spinach", originFarm: "Test Farm", destinationRestaurant: "Test Restaurant", orderStatus: 0, quantity: 10, price: 20, harvestTime: "", restaurantNotes:"", farmerNotes:"", lastUpdateTime: ""
        )
        OrderDetails(
            orderRequest:sampleOrderRequest
//            isShowingOrderDetails: $isShowingOrderDetails
        )
    }
}
