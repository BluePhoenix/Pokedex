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
        mainImageView.image = UIImage(named: "\(pokemon.pokedexID)")
        
        pokemon.downloadPokemonDetails { () -> () in
            self.descriptionLabel.text = self.pokemon.description
            self.typeLabel.text = self.pokemon.type
            self.weightLabel.text = self.pokemon.weight
            self.heightLabel.text = self.pokemon.height
            self.baseAttackLabel.text = self.pokemon.attack
            self.defenseLabel.text = self.pokemon.defense
            // TODO: Finish adding the details here
        }
        
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
