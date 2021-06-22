//
//  APIManager.swift
//  unsplash
//
//  Created by Douglas Jacoveto on 07/06/21.
//

import Foundation
import Alamofire

enum APIManager: URLRequestConvertible {
    
    static let endpoint = URL(string: "https://api.unsplash.com")!
    
    static let endpointString: String = "https://api.unsplash.com"
    
    static let headersRequest: HTTPHeaders? = [
        "Authorization": "Client-ID un3XJDTs8WwqvnAqTz3JWTfWjbIgKXqVk1bNj7_J8eQ",
        "Accept": "application/json"
    ]
    
    case getImage(imageId: String)
    case getAllImages(page:Int)
    
    var path: String {
        switch self {
        // when you need to pass a parameter to the endpoint
        case .getImage(let imageId):
            return "/photos/\(imageId)"
        case .getAllImages(var page):
            return "/photos?page=\(page)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getImage(_):
            return .get
        case .getAllImages(_):
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: APIManager.endpoint.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.addValue("Client-ID un3XJDTs8WwqvnAqTz3JWTfWjbIgKXqVk1bNj7_J8eQ", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    static func getImage(imageId: String, onCompletion: @escaping (ImageElement?) -> Void) {
        AF.request(APIManager.getImage(imageId: imageId)).validate(statusCode: 200..<300).response{(json) in
            switch json.result {
            case .success:
                if let jsonData = json.data {
                    let jsonDecoder = JSONDecoder()
                    let image = try! jsonDecoder.decode(ImageElement.self, from: jsonData)
                    onCompletion(image)
                }
            case.failure(let error):
                print(error)
                onCompletion(nil)
            }
        }
    }
    
    static func getAllImages(page: Int,onCompletion: @escaping ([ImageElement]) -> Void) {
        AF.request(APIManager.getAllImages(page: page)).validate(statusCode: 200..<300).responseJSON {(json) in
            switch json.result {
            case .success:
                if let jsonData = json.data {
                    let jsonDecoder = JSONDecoder()
                    let imageList = try! jsonDecoder.decode([ImageElement].self, from: jsonData)
                    onCompletion(imageList)
                }
            case .failure(let error):
                print(error)
                onCompletion([])
            }
            
        }
    }
    
    static func fetchImages(page: Int, completionHandler: @escaping ([ImageElement]) -> Void) {
        let urlString = "\(endpointString)/photos?page=" + String(page)
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.addValue("Client-ID un3XJDTs8WwqvnAqTz3JWTfWjbIgKXqVk1bNj7_J8eQ", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                completionHandler([])
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                completionHandler([])
                return
            }
            
            do {
                let json = try JSONDecoder().decode([ImageElement].self, from: data! )
                completionHandler(json)
                //print(json)
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
            
        })
        task.resume()
    }}



