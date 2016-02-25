//
//  Pokemon.swift
//  Pokedex
//
//  Created by Felix Barros on 2/23/16.
//  Copyright © 2016 Bits That Matter. All rights reserved.
//

import Foundation
import Alamofire

typealias DownloadComplete = () -> ()

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _defense: String!
    private var _nextEvolutionText: String!
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    var description: String {
        return _description
    }
    var type: String {
        return _type
    }
    var height: String {
        return _height
    }
    var weight: String {
        return _weight
    }
    var baseAttack: String {
        return _baseAttack
    }
    var defense: String {
        return _defense
    }
    var nextEvolutionText: String {
        return _nextEvolutionText
    }
    
    init(name: String, pokedexID: Int) {
        _name = name
        _pokedexID = pokedexID
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        // api/v2/pokemon/{id or name}
        let baseURL = "http://pokeapi.co"
        guard let pokemonURL = NSURL(string: "\(baseURL)/api/v2/pokemon/\(pokedexID)/") else {
            print("Could not generate URL")
            return
        }
        
        Alamofire.request(.GET, pokemonURL).responseJSON { response in
            let result = response.result
            
            print(result.value?.debugDescription)
        }
        
    }
}