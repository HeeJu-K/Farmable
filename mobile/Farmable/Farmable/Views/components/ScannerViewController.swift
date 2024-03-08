//
//  QRCodeViewController.swift
//  Farmable
//
//  Created by HeeJu Kim on 3/4/24.
//

import Foundation
import AVFoundation
import UIKit
import SwiftUI

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var onScanned:((OrderRequest)->Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        captureSession = AVCaptureSession()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            print("SCANNED value", stringValue)
        }

        dismiss(animated: true)
    }

    func found(code: String) {
        print(code)
        guard let data = code.data(using: .utf8) else { return }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 // Adjust based on your date format
            let scannedOrder = try decoder.decode(OrderRequest.self, from: data)
            print("Decoded OrderRequest:", scannedOrder)
            
            DispatchQueue.main.async {
                self.onScanned?(scannedOrder)
            }

        } catch {
            print("Error decoding OrderRequest:", error)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

struct ScannedInfoPopupView: View {
    var scannedOrder: OrderRequest
    @State private var responseData: String?
    @State private var errorMessage: String?

    @Binding var isShowingScanner: Bool
    @Binding var isShowingScannedPopup: Bool

    var body: some View {
        VStack {
            Text("Scanned Information")
                .font(.headline)
            Text("Origin Farm: \(scannedOrder.originFarm)")
            Text("Produce Name: \(scannedOrder.produceName)")
            Text("Quantity: \(scannedOrder.quantity)")
            Text("Price: \(scannedOrder.price)")
            Text("Harvest Time: \(scannedOrder.harvestTime ?? "")")
            Text("Notes from farmer: \(scannedOrder.farmerNotes ?? "")")

            Button("Confirm") {
                
                let updateOrderStatusRequest = UpdateOrderStatusRequest(
                    id: scannedOrder.id,
                    destinationRestaurant: scannedOrder.destinationRestaurant,
                    orderStatus: 4 // Delivered
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
                print("LETS SEE", scannedOrder.produceName,
                      " | ",scannedOrder.quantity,
                      " | ",scannedOrder.price,
                      " | ",scannedOrder.harvestTime ?? "",
                      " | ",scannedOrder.originFarm,
                      " | ",scannedOrder.farmerNotes  ?? "")
                let updateGroceryList = GroceryList(
                    id:"",
                    groceryName: scannedOrder.produceName,
                    quantity: scannedOrder.quantity,
                    price: scannedOrder.price ,
                    harvestTime: scannedOrder.harvestTime ?? "",
                    originFarm: scannedOrder.originFarm,
                    farmerNotes: scannedOrder.farmerNotes ?? ""
                )
                let updateRequest = APIRequest()
                updateRequest.postRequest(requestType:"POST", requestBody: updateGroceryList, endpoint: "/restaurant/grocery/update") { result in
                    switch result {
                    case .success(let data):
                        self.responseData = data
                    case .failure(let error):
                        self.errorMessage = "Error: \(error)"
                    }
                }
                isShowingScanner = false
                isShowingScannedPopup = false
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}


struct ScannerViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ScannerViewController
    
//    @Binding var isPresented: Bool
    @Binding var isShowingScannedPopup: Bool
    @Binding var scannedOrder: OrderRequest?
//    var onScanned:((OrderRequest)->Void)?
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let viewController = ScannerViewController()
        viewController.onScanned = { (scannedOrder: OrderRequest) in
            self.scannedOrder = scannedOrder
            self.isShowingScannedPopup = true
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
    }
}
