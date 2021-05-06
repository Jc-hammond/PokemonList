//
//  PokemonController.swift
//  Pokemon
//
//  Created by Connor Hammond on 5/5/21.
//

import UIKit

class PokemonController {
    
    //MARK: - String Constants
    static let baseURL = URL(string: "https://pokeapi.co/api/v2")
    static let pokemonPathComponent = "pokemon"
    
    //MARK: - Functions
    static func fetchAllPokemon(completion: @escaping (Result<[Pokemon], PokemonError>) -> Void) {
        
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let pokemonURL = baseURL.appendingPathComponent(pokemonPathComponent)
        print(pokemonURL)
        
        URLSession.shared.dataTask(with: pokemonURL) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("POKEMON STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                var pokemonArray: [Pokemon] = []
                for result in topLevelObject.results {
                    fetchPokemonFromURL(url: result.url) { result in
                        switch result {
                        case .success(let pokemon):
                            pokemonArray.append(pokemon)
                            completion(.success(pokemonArray))
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
        
    }
    
   static func fetchPokemonFromURL(url: URL?, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        guard let url = url else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("POKEMON STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do{
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch{
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        
        guard let url = pokemon.sprites.classic else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("SPRITE STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let sprite = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            
            completion(.success(sprite))
        }.resume()
    }
} //End of class
