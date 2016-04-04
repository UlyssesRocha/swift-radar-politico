//
//  DiarioPoliticoTableViewController.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/14/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DiarioPoliticoTableViewController: UITableViewController, DiarioDataControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DiarioDataController.sharedInstance.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DiarioDataController.sharedInstance.lastLoadedProposition
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat((45)+(240)+((40)*DeputadosDataController.sharedInstance.getNumberOfFollowedDeputados()))
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        //NOT SURE IF NEED THIS DISPATCH
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) { () -> Void in
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            
            // Change 10.0 to adjust the distance from bottom
            if (maximumOffset - currentOffset <= 10.0) {
                DiarioDataController.sharedInstance.loadNextPageOfPropositions()
            }
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("VotacaoCell", forIndexPath: indexPath) as! VotacaoCell
        cell.loadWithVotacao(DiarioDataController.sharedInstance.proposicoes[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("DetalhesProposicao", sender: DiarioDataController.sharedInstance.proposicoes[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detalhesView =  segue.destinationViewController as! DetalhesProposicaoViewController
        detalhesView.loadProposicao(sender as! CDProposicao)
    }
    
    func didUpdateData() {
        self.tableView.reloadData()
    }
    
}
