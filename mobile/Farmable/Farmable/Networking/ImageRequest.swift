//
//  ImageRequest.swift
//  Farmable
//
//  Created by HeeJu Kim on 3/3/24.
//

import Foundation
import UIKit

enum ImageError: Error {
    case networkError(Error)
    case invalidResponse
    case invalidData
    
}

//https://farmable.blob.core.windows.net/image-container/NewImage.jpeg?sp=racwdli&st=2024-03-04T01:53:38Z&se=2024-04-04T08:53:38Z&sv=2022-11-02&sr=c&sig=sP7iV6PWdmUXQbCseQ6UeYSerPhoBzYEkXxpYlonloA%3D

struct ImageRequest {
    let imgURL = "https://farmable.blob.core.windows.net/image-container/"
    let SASToken = "?sp=racwdli&st=2024-03-04T01:53:38Z&se=2024-04-04T08:53:38Z&sv=2022-11-02&sr=c&sig=sP7iV6PWdmUXQbCseQ6UeYSerPhoBzYEkXxpYlonloA%3D"

    func putImg (imageData: Data, imageName:String) {
        let url = URL(string: imgURL+imageName+SASToken)!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("BlockBlob", forHTTPHeaderField: "x-ms-blob-type")
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.httpBody = imageData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                print("Image uploaded successfully.")
            } else {
                print("Unexpected response: \(String(describing: response))")
            }
        }

        task.resume()
    }
    
    func getImg (imageName:String, completion: @escaping(Result<UIImage, ImageError>) -> Void) {
        let url = URL(string: imgURL+imageName+SASToken)!
        print("get image called", url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("BlockBlob", forHTTPHeaderField: "x-ms-blob-type")
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("get image network error")
                completion(.failure(.networkError(error)))
                return
                
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("get image invalid response")
                completion(.failure(.invalidResponse))
                return
            }
                
            guard let data = data, let image = UIImage(data: data) else {
                print("get image invalid data")
                completion(.failure(.invalidData))
                return
            }
            print("image successfully loaded")
            completion(.success(image))
        
        }
        task.resume()
    }
}
