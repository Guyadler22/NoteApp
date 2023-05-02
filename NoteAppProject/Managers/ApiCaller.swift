//
//  ApiCaller.swift
//  NoteAppProject
//
//  Created by Guy Adler on 14/02/2023.
//

import Foundation

struct Constants {
    
    static let baseURL = "https://api.mockaroo.com/api/729a5c80?count=120&key=947b40d0"
}

enum ApiError:Error {
    case FailedToGetData(String)
    case badUrl(String)
    case invalidJsonData(String)
}

typealias ApiCallback = (Result<[User], Error>) -> Void


class ApiCaller {
    
    static let shared = ApiCaller()
    private init () {}
    
    func request(url:URL?, completion: @escaping ApiCallback) {
        
        guard let url = URL(string: "\(Constants.baseURL)") else {
            completion(.failure(ApiError.badUrl("The url is badly formatted")))
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, respones, error) in
            if let error = error { completion(.failure(error)); return; }
            guard let data = data else {
                completion(.failure(ApiError.FailedToGetData("The data recived is undifined")))
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print(result as Any)
                            let responesData = try JSONDecoder().decode([User].self, from: data)
                            completion(.success(responesData))
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .resume()
        
    }
}


