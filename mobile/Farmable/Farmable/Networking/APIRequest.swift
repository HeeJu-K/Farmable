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
    let requestURL_local = "http://localhost:8080"
    
    func postRequest<T: Codable> (requestBody: T, endpoint: String, completion: @escaping(Result<T, APIError>) -> Void ) {
        
        do {
            let urlString = self.requestURL_local + endpoint
            guard let url = URL(string: urlString) else {
                completion(.failure(.invalidURL))
                return
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application.json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(requestBody)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else{
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let responseData = try JSONDecoder().decode( T.self, from: jsonData)
                    completion(.success(responseData))
                }catch {
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func getRequest ( endpoint: String, completion: @escaping(Result<Data, APIError>) -> Void ) {

        let urlString = self.requestURL_local + endpoint
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else{
                completion(.failure(.responseProblem))
                return
            }
            completion(.success(jsonData))
        }
        dataTask.resume()
        
    }
}
