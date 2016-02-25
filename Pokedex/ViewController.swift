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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var pokemonData: [Pokemon] = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view,  typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        initAudio()
        parsePokemonCSV()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as? PokemonCollectionViewCell {
            
            cell.configureCell(pokemonData[indexPath.row])
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonData.count
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
                        pokemonData.append(pokemon)
                    }
                }
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
            musicPlayer.volume = 0.8
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func musicButtonPressed(sender: AnyObject) {
        // TODO: Need to implemnt music toggling
    }

}

