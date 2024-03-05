//
//  APIRequest.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/22/24.
//

import Foundation

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
    case invalidURL
}

struct APIRequest {
//    let requestURL = "http://localhost:8080" //local
//    let requestURL = "http://10.0.0.2:8080" //global home
    let requestURL = "http://10.19.179.108:8080" // global school
    
    func postRequest<T: Codable> (requestBody: T, endpoint: String, completion: @escaping(Result<String, APIError>) -> Void ) {
        print("post request caled", requestURL+endpoint)
        do {
            let urlString = self.requestURL + endpoint
            guard let url = URL(string: urlString) else {
                completion(.failure(.invalidURL))
                return
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(requestBody)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else{
                    completion(.failure(.responseProblem))
                    return
                }
                if let responseString = String(data: jsonData, encoding: .utf8) {
                    completion(.success(responseString))
                } else {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func putRequest<T: Codable> (requestBody: T, endpoint: String, completion: @escaping(Result<String, APIError>) -> Void ) {
        print("put request called", requestURL+endpoint)
        do {
            let urlString = self.requestURL + endpoint
            guard let url = URL(string: urlString) else {
                completion(.failure(.invalidURL))
                return
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "PUT"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(requestBody)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else{
                    completion(.failure(.responseProblem))
                    return
                }
                if let responseString = String(data: jsonData, encoding: .utf8) {
                    completion(.success(responseString))
                } else {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func getRequest ( endpoint: String, completion: @escaping(Result<Data, APIError>) -> Void ) {
        print("get request new")
        let urlString = self.requestURL + endpoint
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data
            else{
                completion(.failure(.responseProblem))
                return
            }
            print(responseData)
            completion(.success(responseData))
        }
        dataTask.resume()
        
    }
}
