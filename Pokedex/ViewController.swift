//
//  ViewController.swift
//  Pokedex
//
//  Created by Felix Barros on 2/23/16.
//  Copyright © 2016 Bits That Matter. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftCSV

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainSearchBar: UISearchBar!

    var allPokemonData: [Pokemon] = [Pokemon]()
    var pokemonData: [Pokemon] = [Pokemon]()
    var filteredPokemon: [Pokemon] = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var isFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view,  typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        mainSearchBar.delegate = self
        
        initAudio()
        parsePokemonCSV()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as? PokemonCollectionViewCell {
            
            if isFiltering {
                cell.configureCell(filteredPokemon[indexPath.row])
            } else {
                cell.configureCell(pokemonData[indexPath.row])
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPokemon.count
        } else {
            return pokemonData.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(104, 104)
    }
    
    // MARK: Data handling
    func parsePokemonCSV() {
        
        if let filePath = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv") {
            do {
                let csv = try CSV(name: filePath, delimiter: NSCharacterSet(charactersInString: ","), encoding: NSUTF8StringEncoding)
                let rows = csv.rows
                
                for row in rows {
                    if let stringID = row["id"],
                    let pokemonID = Int(stringID),
                    let pokemonName = row["identifier"] {
                        let pokemon = Pokemon(name: pokemonName, pokedexID: pokemonID)
                        allPokemonData.append(pokemon)
                    }
                }
                
                pokemonData = allPokemonData
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
    }
    
    func initAudio() {
        guard let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3"), let musicURL = NSURL(string: path) else {
            print("Could not load music")
            return
        }
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: musicURL)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.volume = 0.6
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func musicButtonPressed(sender: UIButton) {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.38
        } else {
            musicPlayer.play()
            sender.alpha = 1
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isFiltering = false
        } else {
            let lowerSearchString = searchBar.text!.lowercaseString
            filteredPokemon = allPokemonData.filter({$0.name.rangeOfString(lowerSearchString) != nil})
            isFiltering = true
        }
        
        collectionView.reloadData()
    }

}

