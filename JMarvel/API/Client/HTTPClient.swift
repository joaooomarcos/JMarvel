//
//  HTTPClient.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 18/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import UIKit

public final class HTTPClient {
    
    // MARK: - Variables
    
    private var remoteTask: URLSessionTask?
    
    // MARK: - Public
    
    public func request<T: Decodable>(_ request: Request, completion: @escaping (_ result: Result<T>) -> Void) {
        
        var urlRequest = self.prepareRequest(request)
        urlRequest.httpMethod = request.method?.rawValue ?? HTTPMethod.get.rawValue
        
        remoteTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.error(GenericError(error: error)))
                    } else {
                        completion(.error(GenericError(message: "Data empty")))
                    }
                }
                return
            }
            
            do {
                let model = try JSONDecoder().decode(ResultModel<T>.self, from: data)
                if let data = model.data {
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.error(GenericError(result: model)))
                    }
                }
            } catch let decoderError {
                do {
                    let error = try JSONDecoder().decode(GenericError.self, from: data)
                    DispatchQueue.main.async {
                        completion(.error(error))
                    }
                } catch {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    DispatchQueue.main.async {
                        completion(.error(GenericError(error: decoderError, statusCode: statusCode)))
                    }
                }
            }
        }
        remoteTask?.resume()
    }
    
    // MARK: - Privates
    
    private func prepareRequest(_ request: Request) -> URLRequest {
        var url = request.endpoint.url
        let query = self.defaultParameters + "&" + request.parameters.queryString
        
        url += "?" + query
        
        if let auxURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            url = auxURL
        }
        
        guard let newUrl = URL(string: url) else {
            fatalError("Fail on get url request")
        }
        
        return URLRequest(url: newUrl)
    }
    
    private var defaultParameters: String {
        let time = timestamp
        let hash = apiHash(timestamp: time)
        return "apikey=\(Constants.API.publicKey)&ts=\(time)&hash=\(hash)"
    }
    
    private func apiHash(timestamp: String) -> String {
        let seed = timestamp + Constants.API.privateKey + Constants.API.publicKey
        return CryptoHelper.md5(with: seed)
    }
    
    private var timestamp: String {
        "\(Date().timeIntervalSince1970)"
    }
}
