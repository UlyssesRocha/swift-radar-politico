//
//  DiarioPoliticoTableViewController.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/14/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DiarioPoliticoTableViewController: UITableViewController {

    
    var proposicoes:[CDProposicao] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ano:UInt = 2015
        CDProposicao.loadDistinctCodProposicoesVotedIn(ano, withCompletionHandler: { (votacoes) -> Void in
            for i in votacoes {
                if let prepId = i as? NSString{
                    let proposicao = CDProposicao.init(codProposicao: prepId.integerValue)
                    self.proposicoes.append(proposicao)
                }
            }
            self.loadPreposicaoAtIndex(0)
            self.tableView.reloadData()
        })
    }
    
    // testing --------------
    func loadPreposicaoAtIndex(var index:Int){
        if index >= self.proposicoes.count{
            return
        }
        
        print("inicia carregamento preposicao \(proposicoes[index].idProposicao)")
        proposicoes[index].loadProposicao({ () -> Void in
            if self.proposicoes[index].nome != nil{
                self.proposicoes[index].loadVotacoes({ () -> Void in
                    if let _ = self.proposicoes[index].votacoes{
                    }else{
                        print("erro votacao \(self.proposicoes[index].idProposicao) ")
                    }
                    self.tableView.reloadData()
                    self.loadPreposicaoAtIndex(index+1)
                })
            }
        })
    }
    // testing --------------


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
        return proposicoes.count
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel?.text = proposicoes[indexPath.row].nome
        cell.detailTextLabel?.text = proposicoes[indexPath.row].nomeAutor
        
        return cell
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
