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
        if let validData = String(data: data,encoding: .utf8){
            print(validData)
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
    let orderRequest: OrderRequest
    internal init(orderRequest: OrderRequest) {
        self.orderRequest = orderRequest
    }
    
    @State private var farmerNotes: String = ""
    @State private var showQRCode: Bool = false
    
    @State private var responseData: String?
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(alignment: .leading){
            Group{
                HStack{
                    Text("Produce Name: ")
                    Text(orderRequest.produceName)
                }
                HStack{
                    Text("Origin Farm: ")
                    Text(orderRequest.originFarm)
                }
                HStack{
                    Text("Produce Price: ")
                    Text(String(orderRequest.price))
                }
                HStack{
                    Text("Order Quantity: ")
                    Text(String(orderRequest.quantity))
                }
                Group{
                    if orderRequest.restaurantNotes != ""{
                        Text("Notes from restaurant owners: ")
                        Text(orderRequest.restaurantNotes ?? "")
                    } else {
                        Text("There were no specific instructions from the restaurant.")
                            .font(.system(size:12))
                    }
                }
            }
            //for order before accept
            if orderRequest.orderStatus == 0{
                Group{
                    Spacer()
                        .frame(height: 20)
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
                                request.putRequest(requestBody: updateOrderStatusRequest, endpoint: "/order/update") { result in
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
                        Button("Decline"){}
                        Spacer()
                    }
                }
            }
            // for accepted order to be harvested
            if orderRequest.orderStatus==1{
                Group{
                    HStack{
                        Text("Notes for Restaurant:")
                        TextField("Add notes here", text:$farmerNotes)
                            .frame(width:200)
                    }
                    Text("Please provide details of your farming practices. This is not required but will help restaurants and customers better understand values of your produces.")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 13))
                        .foregroundStyle(.gray)
                        .padding(.leading)
                        .multilineTextAlignment(.leading)
                    Button("Generate QR Code") {
                        self.showQRCode = true
                        let addHarvestTimeRequest = AddHarvestTimeRequest(
                            id: orderRequest.id,
                            farmerNotes: farmerNotes,
                            destinationRestaurant: orderRequest.destinationRestaurant
                        )
                        let request = APIRequest()
                        request.putRequest(requestBody: addHarvestTimeRequest, endpoint: "/order/harvest") { result in
                            switch result {
                            case .success(let data):
                                self.responseData = data
                                self.showQRCode = true
                            case .failure(let error):
                                self.errorMessage = "Error: \(error)"
                            }
                        }
                    }
                    if showQRCode {
                        QRCodeView(image: generateQRCode(from: orderRequest))
                    }
                }
            }
            // for harvested order shipped
            if orderRequest.orderStatus == 2 {
                Button(action: {
                    let updateOrderStatusRequest = UpdateOrderStatusRequest(
                        id: orderRequest.id,
                        destinationRestaurant: orderRequest.destinationRestaurant,
                        orderStatus: 3 // Delivered
                    )
                    let request = APIRequest()
                    request.putRequest(requestBody: updateOrderStatusRequest, endpoint: "/order/update") { result in
                        switch result {
                        case .success(let data):
                            self.responseData = data
                        case .failure(let error):
                            self.errorMessage = "Error: \(error)"
                        }
                    }
                }) {
                Label("Delivered", systemImage: "bag")
                  .padding(10)
                  .foregroundColor(.white)
                  .background(Color.green)
                  .cornerRadius(7)
              }
            }
            // for shipped order
            if orderRequest.orderStatus == 3 {
                Spacer()
                    .frame(height: 10)
                Text("This order is on delivery, \\n waiting for restaurant to confirm delivery.")
            }
            Spacer()
        }
    }
}


struct OrderDetails_Previews: PreviewProvider {
    @State static var isShowingOrderDetails: Bool = true
    static var previews: some View {
        
        let sampleOrderRequest = OrderRequest(
            id: "fwefqwa", produceName: "Spinach", originFarm: "Test Farm", destinationRestaurant: "Test Restaurant", orderStatus: 3, quantity: 10, price: 20, harvestTime: "", restaurantNotes:"", farmerNotes:"", lastUpdateTime: ""
        )
        OrderDetails(
            orderRequest:sampleOrderRequest
//            isShowingOrderDetails: $isShowingOrderDetails
        )
    }
}
