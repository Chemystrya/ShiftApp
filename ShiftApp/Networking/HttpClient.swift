//
//  HttpClient.swift
//  ShiftApp
//
//  Created by Fedorova Maria on 04.07.2025.
//

import Foundation

protocol HttpClientProtocol {
    func send<T: Request>(_ request: T, completionHandler: @escaping (Result<T.ResponseType, Error>) -> Void)
}

final class HttpClient: HttpClientProtocol {
    func send<T: Request>(_ request: T, completionHandler: @escaping (Result<T.ResponseType, Error>) -> Void) {
        guard let url = request.url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completionHandler(.failure(error))
                return
            }

            guard let data else {
                completionHandler(.failure(NSError(domain: "NoData", code: -1, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(T.ResponseType.self, from: data)
                completionHandler(.success(decodedResponse))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}
