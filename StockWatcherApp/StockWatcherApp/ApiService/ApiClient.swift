//
//  ApiClient.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 27.08.24.
//

import Foundation

class ApiClient{
    
    // Singleton Instance
    static let shared = ApiClient()
    
    //API Call
    func makeRequest <T:Codable> (
        scheme:String,
        host:String,
        path:String,
        queryItemFirst:String? = nil,
        queryItemSecond:String? = nil,
        queryItemThird:String? = nil,
        queryItemFourth:String? = nil,
        headers:[String:String]? = nil ,
        body:[String:Any]? = nil ,
        method:String? = nil ,
        userFirstInput:String? = nil ,
        userSecondInput:String? = nil,
        userThirdInput:String? = nil,
        userFourthInput:String? = nil )  async throws  -> T? {
            
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = path
            
            urlComponents.queryItems = [
                URLQueryItem(name:queryItemFirst ?? "", value: userFirstInput),
                URLQueryItem(name:queryItemSecond ?? "",value: userSecondInput),
                URLQueryItem(name:queryItemThird ?? "",value: userThirdInput),
                URLQueryItem(name:queryItemFourth ?? "",value: userFourthInput)
            ]
            
            guard let  url = urlComponents.url else{
                throw ApiErrors.invalidUrl
            }
            
            var request = URLRequest(url: url)
            request.httpMethod  = method ?? "GET"
            request.allHTTPHeaderFields = headers
            
            if method == "POST" , let body = body{
                do{
                    request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }catch{
                    throw ApiErrors.badResponse
                }
            }
            
            let (data,response) =  try await URLSession.shared.data(for: request)
            
            
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let  statusCode = (response as? HTTPURLResponse)?.statusCode else{
                throw ApiErrors.unknownError
            }
            
            print(statusCode)
            
            //Here we handle the errors from API with the most common status codes.
            switch statusCode{
            case 200:
                do{
                    return try decoder.decode(T.self, from: data)
                }catch{
                    print(error)
                    print(ApiErrors.decodingError.rawValue)
                    throw ApiErrors.decodingError
                }
            case 400:
                print(ApiErrors.badResponse.rawValue)
                throw ApiErrors.badResponse
            case 401:
                print(ApiErrors.authenticationMissing.rawValue)
                throw ApiErrors.authenticationMissing
            case 404:
                print(ApiErrors.notFound.rawValue)
                throw ApiErrors.notFound
            case 429:
                print(ApiErrors.tooManyRequests.rawValue)
                throw ApiErrors.tooManyRequests
            default:
                print(ApiErrors.unknownError.rawValue)
                throw ApiErrors.unknownError
            }
        }
    
    
    
    func makeMockRequest<T:Codable>(url:String) async throws ->T? {
        
        let url =  URL(string: url)

        guard let url = url else{
            throw ApiErrors.invalidUrl
        }
       
        let data = try await URLSession.shared.data(from: url).0
       
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let results = try decoder.decode(T.self, from: data)
        
        return results
    }
}
