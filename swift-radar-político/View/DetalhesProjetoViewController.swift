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
    private var dataRaw:[[String:String]] = [[:]]
    
    func loadProposicao(proposicao:CDProposicao){
        self.proposicao = proposicao
        
        self.dataRaw = [
            ["data" : proposicao.tipoProposicao ,"info" : "Tipo de Proposição"],
            ["data" : proposicao.tema ,"info" : "Tema"],
            ["data" : proposicao.ementa ,"info" : "Ementa"],
            ["data" : proposicao.explicacaoEmenta ,"info" : "Explicação Ementa"],
            ["data" : proposicao.indexacao ,"info" : "Indexação"],
            ["data" : proposicao.regimeTramitacao ,"info" : "Regime de Tramitação"],
            ].filter({ (element) -> Bool in
                return !element["data"]!.isEmpty
            })
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tituloProposicaoLabel.text = proposicao?.nome
        self.tableView.reloadData()
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return calcNumberOfRows()
        }
        return  0
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetalheCell", forIndexPath: indexPath) as! DetalheCell

        let itemData = getNextDetailItem(indexPath.row)
        
        cell.infoLabel?.text = itemData.0
        cell.dataText.text = itemData.1
        
        return cell
    }
    
    private func calcNumberOfRows()->Int{
        return self.dataRaw.count
    }
    
    private func getNextDetailItem(index:Int)->(String,String){
        return (dataRaw[index]["info"]!,dataRaw[index]["data"]!)
    }

   }
