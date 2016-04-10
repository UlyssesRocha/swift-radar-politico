//
//  VotosViewController.swift
//  swift-radar-político
//
//  Created by Ulysses on 4/10/16.
//  Copyright © 2016 Dados Abertos Brasil. All rights reserved.
//

import UIKit

class VotosViewController: UITableViewController,UISearchBarDelegate, UISearchResultsUpdating {

    var votacao:CDVotacao?
    var filteredResults:[AnyObject]?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        votacao?.votoDeputados.sortInPlace({ (A, B) -> Bool in
            return (A.objectForKey("Nome") as! String) < (B.objectForKey("Nome") as! String)
        })
        
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        definesPresentationContext = true
        self.searchController.dimsBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["Todos", "Sim", "Não", "Obstrução"]
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.active ? self.filteredResults!.count : votacao?.votoDeputados.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("VotoCell", forIndexPath: indexPath) as! VotoDeputadoCell
        
        let votoDeputado = searchController.active ? self.filteredResults![indexPath.row] :votacao!.votoDeputados![indexPath.row]
        
        let nomeDeputado = votoDeputado.objectForKey("Nome") as! String
        let deputado = DeputadosDataController.sharedInstance.getDeputadoByName(nomeDeputado)
        
        //Name --
        cell.nomeDeputadoText.text = deputado?.nomeParlamentar.capitalizedString ?? nomeDeputado.capitalizedString
        
        //Image ---
        cell.fotoDeputadoImage?.image = nil
        
        if deputado != nil{
            cell.fotoDeputadoImage?.roundCorner()
            cell.fotoDeputadoImage?.highlightCorner()
            deputado?.loadPhoto(cell.fotoDeputadoImage)
            
            cell.partidoDeputadoText.hidden = false
            cell.partidoDeputadoText.text = deputado?.partido
        }else{
            cell.partidoDeputadoText.hidden = true
        }
        
        //Vote --
        cell.votoText.text = votoDeputado.objectForKey("Voto") as? String
        
        return cell
    }
    
    
    func filterContentForSearchText(searchText: String , scope: String = "Todos") {
        
        self.filteredResults = votacao?.votoDeputados!.filter({(voto) -> Bool in
            
            var scopeFilter:Bool = false
            
            switch scope {
            case "Sim":
                scopeFilter = (voto.objectForKey("Voto") as! String).containsString("Sim")
            case "Não":
                scopeFilter = (voto.objectForKey("Voto") as! String).containsString("Não")
            case "Obstrução":
                scopeFilter = (voto.objectForKey("Voto") as! String).containsString("Obstrução")
            default:
                scopeFilter = true
            }
            
            if searchText.isEmpty {
                return scopeFilter
            }
            
            let textFilter = (voto.objectForKey("Nome") as! String).lowercaseString.containsString(searchText.lowercaseString)
            
            return scopeFilter && textFilter
        })
        
        tableView.reloadData()
    }

    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        tableView.reloadData()
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }

}
