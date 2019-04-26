//
//  APIService.swift
//  MyCV
//
//  Created by Dima Dobrovolskyy on 4/25/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func fetchData<Struct: Codable>(struct: Struct, completion: @escaping (Result<Struct, Error>) -> ())
}

class APIService: APIServiceProtocol {
    
    func fetchData<Struct: Codable>(struct: Struct, completion: @escaping (Result<Struct, Error>) -> ()) {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "json") else { return }
        
        URLSession.shared.dataTask(with: URL(fileURLWithPath: path)) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let structuralParts = try JSONDecoder().decode(Struct.self, from: data!)
                completion(.success(structuralParts))
            } catch let jsonError{
                completion(.failure(jsonError))
            }
            
        }.resume()
    }
    
}
