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
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        nameLabel.text = pokemon?.name
    }

}
