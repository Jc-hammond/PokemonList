//
//  PokemonListTableViewController.swift
//  Pokemon
//
//  Created by Connor Hammond on 5/5/21.
//

import UIKit

class PokemonListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPokemonForTableView()
    }
    
    //MARK: - Properties
    var pokemon: [Pokemon] = []
    
    //MARK: - Functions
    func fetchPokemonForTableView() {
        PokemonController.fetchAllPokemon { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.pokemon = pokemon
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath) as? PokemonTableViewCell
        
        let pokemon = pokemon[indexPath.row]
        cell?.pokemon = pokemon
        return cell ?? UITableViewCell()
    }
    
} //End of class
