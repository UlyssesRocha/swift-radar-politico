//
//  DetalhesProjetoViewController.swift
//  swift-radar-político
//
//  Created by Ulysses on 4/1/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DetalhesProposicaoViewController: UITableViewController {

    @IBOutlet weak var tituloProposicaoLabel: UILabel!
    
    @IBOutlet weak var autorImage: UIImageView!
    
    @IBOutlet weak var autorNomeLabel: UILabel!
    
    @IBOutlet weak var autorPartidoLabel: UILabel!
    
    @IBOutlet weak var lerProjetoButton: UIButton!
    
    private var proposicao:CDProposicao?
    private let sections = ["Detalhes","Votacoes"]
    
    func loadProposicao(proposicao:CDProposicao){
        self.proposicao = proposicao
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tituloProposicaoLabel.text = proposicao?.nome
        self.tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 3
        }
        return  0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetalheCell", forIndexPath: indexPath) as! DetalheCell

        if indexPath.section == 0{
            switch indexPath.row {
            case 0:
                cell.infoLabel?.text = "Tema"
                cell.dataText.text = proposicao?.tema
            case 1:
                cell.infoLabel?.text = "Emeneta"
                cell.dataText.text = proposicao?.ementa
            default:
                cell.infoLabel?.text = "Indexação"
                cell.dataText.text = proposicao?.indexacao
            }
        }
        
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
