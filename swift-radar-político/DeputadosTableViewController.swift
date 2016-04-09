//
//  DeputadosTableViewController.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/29/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DeputadosTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        DeputadosDataController.sharedInstance.followDeputadoWithId(178957)
        DeputadosDataController.sharedInstance.followDeputadoWithId(178914)

    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        self.navigationController?.navigationBar.topItem?.title = "Deputados Federais"
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DeputadosDataController.sharedInstance.deputados?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeputadoCell", forIndexPath: indexPath) as! DeputadoCell
        
        cell.loadWithDeputado(DeputadosDataController.sharedInstance.deputados![indexPath.row])

        return cell
    }

}
