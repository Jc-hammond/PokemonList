//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Connor Hammond on 5/5/21.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeAbilitiesLabel: UILabel!
    
    
    //MARK: - Properties
    var pokemon: Pokemon? {
        didSet{
            updateViews()
        }
    }
    
    //MARK: - Functions
    func updateViews() {
        
        guard let pokemon = pokemon else {return}
      
        pokeNameLabel.text = pokemon.name
        var abilityString: [String] = []

        for abilities in pokemon.abilities {
            let abilityName = abilities.ability.name
            abilityString.append(abilityName)
        }
        pokeAbilitiesLabel.text = abilityString.joined(separator: ", ")

        PokemonController.fetchSprite(for: pokemon) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    self.pokeImageView.image = sprite
                    
                case .failure(let error):
                self.pokeImageView.image = UIImage(named: "noPokemonSprite")
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        
    }
} //End of class
