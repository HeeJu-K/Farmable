//
//  OrderDetails.swift
//  Farmable
//
//  Created by HeeJu Kim on 3/1/24.
//

import SwiftUI

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
    
    var body: some View {
        VStack{
            Text("Order name")
            Text("Origin Farm")
            Text("Order Status")
            Button("Generate QR Code") {
                
            }
            QRCodeView(image: generateQRCode(from: orderRequest))
        }
    }
}

struct OrderDetails_Previews: PreviewProvider {
    @State static var isShowingOrderDetails: Bool = true
    static var previews: some View {
        
        let sampleOrderRequest = OrderRequest(
        id: "fwefqwa", originFarm: "Test Farm", destinationRestaurant: "Test Restaurant", orderStatus: 0, quantity: 10, price: 20, timestamp: "", lastUpdateTime: ""
        )
        OrderDetails(
            orderRequest:sampleOrderRequest
//            isShowingOrderDetails: $isShowingOrderDetails
        )
    }
}
