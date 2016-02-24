//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Felix Barros on 2/23/16.
//  Copyright © 2016 Bits That Matter. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        thumbnailImage.layer.cornerRadius = 6
        nameLabel.layer.cornerRadius = 6
        
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbnailImage.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }
}
