//
//  DiarioPoliticoTableViewController.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/14/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DiarioPoliticoTableViewController: UITableViewController, DiarioDataControllerDelegate {
    
    private var isLoadingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DiarioDataController.sharedInstance.delegate = self
        
        self.tableView.backgroundColor = UIColor(netHex: Constants.background)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        
        self.navigationController?.navigationBar.topItem?.title = "Votações Na Câmara"
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 + (isLoadingData == true ? 1 : 0)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return DiarioDataController.sharedInstance.lastLoadedProposition
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat((240)+((40)*DeputadosDataController.sharedInstance.getNumberOfFollowedDeputados())) + 20
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom
        if (maximumOffset - currentOffset <= 10.0) {
            DiarioDataController.sharedInstance.loadNextPageOfPropositions()
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCellWithIdentifier("VotacaoCell", forIndexPath: indexPath) as! VotacaoCell
            (cell as! VotacaoCell).loadWithVotacao(DiarioDataController.sharedInstance.proposicoes[indexPath.row])
            
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("LoadingCell", forIndexPath: indexPath)
            (cell.viewWithTag(1) as! UIActivityIndicatorView).startAnimating()
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            self.performSegueWithIdentifier("DetalhesProposicao", sender: DiarioDataController.sharedInstance.proposicoes[indexPath.row])
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detalhesView =  segue.destinationViewController as! DetalhesProposicaoViewController
        detalhesView.loadProposicao(sender as! CDProposicao)
    }
    
    func didUpdateData() {
        self.tableView.reloadData()
    }
    
    func willLoadData() {
        isLoadingData = true
        self.tableView.reloadData()
    }
    func didStopLoadData() {
        isLoadingData = false
        self.tableView.reloadData()
    }
}
