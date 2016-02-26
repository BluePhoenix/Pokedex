//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Felix Barros on 2/24/16.
//  Copyright © 2016 Bits That Matter. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var nextEvolutionLabel: UILabel!
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        nameLabel.text = pokemon.name
        let currentPokemonImage = UIImage(named: "\(pokemon.pokedexID)")
        mainImageView.image = currentPokemonImage
        currentEvolutionImage.image = currentPokemonImage
        
        // This call to updateData() might return with empty strings
        // if the data has not yet been downloaded
        updateData()
        
        // TODO: Change this to only get called if data is missing
        pokemon.downloadPokemonDetails { () -> () in
            // Yes, call again after download is complete
            self.updateData()
        }
        
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateData() {
        nameLabel.text = pokemon.name.capitalizedString
        pokedexIDLabel.text = String.init(format: "#%03d", pokemon.pokedexID)
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        weightLabel.text = pokemon.weight
        heightLabel.text = pokemon.height
        baseAttackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        
        nextEvolutionImage.image = UIImage(named: "\(pokemon.nextEvolutionID)")
        nextEvolutionLabel.text = pokemon.nextEvolutionText
    }
}
