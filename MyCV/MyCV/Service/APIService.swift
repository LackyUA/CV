//
//  APIService.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    case contentNotFound
}

protocol APIServiceProtocol {
    func fetchData<Model: Codable>(class: Model, completion: @escaping (Result<Model, Error>) -> ())
    func fetch<Model: Decodable>(_ type: Model.Type) async throws -> Model
}

class APIService: APIServiceProtocol {
    
    func fetchData<Model: Codable>(class: Model, completion: @escaping (Result<Model, Error>) -> ()) {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "json") else { return }
        
        URLSession.shared.dataTask(with: URL(fileURLWithPath: path)) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let structuralParts = try JSONDecoder().decode(Model.self, from: data!)
                completion(.success(structuralParts))
            } catch let jsonError{
                completion(.failure(jsonError))
            }
            
        }.resume()
    }
    
    /// Loads and decodes the bundled `Content.json` into the requested model type.
    func fetch<Model: Decodable>(_ type: Model.Type) async throws -> Model {
        guard let url = Bundle.main.url(forResource: "Content", withExtension: "json") else {
            throw APIServiceError.contentNotFound
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Model.self, from: data)
    }
    
}
