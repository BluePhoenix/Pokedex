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
    private var _attack: String!
    private var _defense: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionID: String!
    
    var name: String {
        return _name ?? ""
    }
    var pokedexID: Int {
        return _pokedexID ?? 0
    }
    var description: String {
        return _description ?? ""
    }
    var type: String {
        return _type ?? ""
    }
    var height: String {
        return _height ?? ""
    }
    var weight: String {
        return _weight ?? ""
    }
    var attack: String {
        return _attack ?? ""
    }
    var defense: String {
        return _defense ?? ""
    }
    var nextEvolutionText: String {
        return _nextEvolutionText ?? ""
    }
    var nextEvolutionID: String {
        return _nextEvolutionID ?? ""
    }
    
    init(name: String, pokedexID: Int) {
        _name = name
        _pokedexID = pokedexID
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        // api/v2/pokemon/{id or name}
        let baseURL = "http://pokeapi.co"
        guard let pokemonURL = NSURL(string: "\(baseURL)/api/v1/pokemon/\(pokedexID)/") else {
            print("Could not generate URL")
            return
        }
        
        Alamofire.request(.GET, pokemonURL).responseJSON { response in
            let result = response.result
            
            guard let resultDictionary = result.value as? [String: AnyObject] else {
                return
            }
            
            if let weight = resultDictionary["weight"] as? String {
                self._weight = weight
            }
            if let height = resultDictionary["height"] as? String {
                self._height = height
            }
            if let attack = resultDictionary["attack"] as? Int {
                self._attack = "\(attack)"
            }
            if let defense = resultDictionary["defense"] as? Int {
                self._defense = "\(defense)"
            }
            
            if let types = resultDictionary["types"] as? [[String: String]] where types.count > 0 {
                var separator = ""
                var typeString = ""
                for type in types {
                    if let typeName = type["name"] {
                        typeString = typeString + separator + typeName.capitalizedString
                        separator = " / "
                    }
                }
                self._type = typeString
            }
            
            if let descriptions = resultDictionary["descriptions"] as? [[String: String]] where descriptions.count > 0, let resourceURI = descriptions[0]["resource_uri"], let resourceURL = NSURL(string: (baseURL + resourceURI)) {
                
                Alamofire.request(.GET, resourceURL).responseJSON(completionHandler: { (descriptionResponse) -> Void in
                    if let descriptionDictionary = descriptionResponse.result.value as? [String: AnyObject], let description = descriptionDictionary["description"] as? String {
                        self._description = description
                    } else {
                        self._description = ""
                    }
                    completed()
                })
            }
            
            if let evolutions = resultDictionary["evolutions"] as? [[String: AnyObject]] where evolutions.count > 0 {
                if let nextEvolution = evolutions[0]["to"] as? String,
                let level = evolutions[0]["level"],
                let resourceURI = evolutions[0]["resource_uri"] {
                    
                    // Ignore 'mega' evolutions for now
                    if nextEvolution.rangeOfString("mega") == nil {
                        let trimmedURI = resourceURI.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                        let nextPokemonID = trimmedURI.stringByReplacingOccurrencesOfString("/", withString: "")
                        
                        self._nextEvolutionID = nextPokemonID
                        self._nextEvolutionText = "\(nextEvolution) at level \(level)"
                    }
                }
            }
            
            completed()
        }
        
    }
    
}