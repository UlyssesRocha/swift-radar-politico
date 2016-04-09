//
//  DeputadosTableViewController.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/29/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DeputadosTableViewController: UITableViewController,UISearchBarDelegate, UISearchResultsUpdating{
    
    var filteredResults:[CDDeputado] = []
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        definesPresentationContext = true
        self.searchController.dimsBackgroundDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["Todos", "Titulares", "Suplentes", "Seguindo"]

    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.tableView.reloadData()
        self.navigationController?.navigationBar.topItem?.title = "Deputados Federais"
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  searchController.active ? self.filteredResults.count :DeputadosDataController.sharedInstance.deputados?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DeputadoCell", forIndexPath: indexPath) as! DeputadoCell
        
            cell.loadWithDeputado(searchController.active ? filteredResults[indexPath.row] :  DeputadosDataController.sharedInstance.deputados![indexPath.row] )
        
         return cell
    }
    
    
    func filterContentForSearchText(searchText: String , scope: String = "Todos") {
        
        self.filteredResults = DeputadosDataController.sharedInstance.deputados!.filter({( deputado : CDDeputado) -> Bool in
            
            var scopeFilter:Bool = false
            
            switch scope {
                case "Seguindo":
                scopeFilter = DeputadosDataController.sharedInstance.isDeputadoFoollowed(Int(deputado.ideCadastro))
                case "Titulares":
                scopeFilter = deputado.condicao! == "Titular"
                case "Suplentes":
                scopeFilter = deputado.condicao! == "Suplente"
                default:
                scopeFilter = true
            }
            
            if searchText.isEmpty {
                return scopeFilter
            }
            
            let textFilter = (deputado.nome.lowercaseString.containsString(searchText.lowercaseString) ||
                             (deputado.partido.lowercaseString.containsString(searchText.lowercaseString) ||
                             (deputado.nomeParlamentar.lowercaseString.containsString(searchText.lowercaseString))))
            
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


