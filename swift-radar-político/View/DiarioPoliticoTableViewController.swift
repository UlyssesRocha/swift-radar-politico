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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Proposicao", forIndexPath: indexPath) as! ProposicaoTableViewCell

        cell.title.text = DiarioDataController.sharedInstance.proposicoes[indexPath.row].nome
        
        if let votacao =  DiarioDataController.sharedInstance.proposicoes[indexPath.row].votacoes.first as? CDVotacao{
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            
            cell.date.text  = dateFormatter.stringFromDate(votacao.data)
            
            cell.summaryProposicao.text = DiarioDataController.sharedInstance.proposicoes[indexPath.row].ementa
            cell.summaryProposicao.scrollRectToVisible(CGRect(x: 0,y: 0,width: 0,height: 1), animated: false)
        }
        
        
        return cell
    }
    
    func didUpdateData() {
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            
        return  150
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
