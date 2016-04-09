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
    @IBOutlet weak var autorNomeLabel: UILabel!
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
        self.autorNomeLabel.text = proposicao?.nomeAutor
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return calcNumberOfRows()
        }
        return  0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let itemData = getNextDetailItem(indexPath.row)
        return itemData.1.calculateHeightForString(16.0, screnSize: self.view.frame.size, padding: 35.0) + 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetalheCell", forIndexPath: indexPath) as! DetalheCell

        let itemData = getNextDetailItem(indexPath.row)
        cell.infoLabel?.text = itemData.0
        cell.dataText.text = itemData.1
        
        return cell
    }
    
    @IBAction func lerProjeto(sender: AnyObject) {
        if let proposicao = self.proposicao,
            let urlString = proposicao.urlInteiroTeor,
            let url = NSURL(string: urlString){
            UIApplication.sharedApplication().openURL(url)
        }else{
            print("error")
        }
    }
    
    //MARK: Private Func
    private func calcNumberOfRows()->Int{
        return self.dataRaw.count
    }
    
    private func getNextDetailItem(index:Int)->(String,String){
        return (dataRaw[index]["info"]!,dataRaw[index]["data"]!)
    }

   }
