//
//  DetalhesProjetoViewController.swift
//  swift-radar-político
//
//  Created by Ulysses on 4/1/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DetalhesProposicaoViewController: UITableViewController {

    @IBOutlet weak var bkHeaderView: UIView!
    @IBOutlet weak var tituloProposicaoLabel: UILabel!
    @IBOutlet weak var autorNomeLabel: UILabel!
    @IBOutlet weak var lerProjetoButton: UIButton!
    
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
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
        
        self.bkHeaderView.roundCorner()
        self.bkHeaderView.highlightCorner()
        self.tableView.backgroundColor = UIColor(netHex: Constants.background)
        self.lerProjetoButton.roundCorner()
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.segmentControll.selectedSegmentIndex == 0 ? self.sections.count : 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.segmentControll.selectedSegmentIndex == 0 ? (section == 0 ? calcNumberOfRows() : 0) : self.proposicao!.votacoes.count
    }
    
    //TODO: Improve calc of height
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if self.segmentControll.selectedSegmentIndex == 0 {
            let itemData = getNextDetailItem(indexPath.row)
            return itemData.1.calculateHeightForString(16.0, screnSize: self.view.frame.size, padding: 35.0) + 50
        }else{
            let votacao = (self.proposicao?.votacoes[indexPath.row] as! CDVotacao)
            return votacao.objVotacao.calculateHeightForString(16.0, screnSize: self.tableView.frame.size, padding: 40.0) + votacao.resumo.calculateHeightForString(16.0, screnSize: self.tableView.frame.size, padding: 40.0) + 70
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if self.segmentControll.selectedSegmentIndex == 0 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("DetalheCell", forIndexPath: indexPath) as! DetalheCell

            let itemData = getNextDetailItem(indexPath.row)
            cell.infoLabel?.text = itemData.0
            cell.dataText.text = itemData.1
            
            return cell
        }else{
            let cell = self.tableView.dequeueReusableCellWithIdentifier("Teste", forIndexPath: indexPath) as! VotacaoDetailCell
            
            cell.loadWithVotaocao(self.proposicao?.votacoes[indexPath.row] as! CDVotacao)
            
            return cell
        }
    }
    
    @IBAction func didChangeSegmentIndex(sender: AnyObject) {
        self.tableView.reloadData()
    }
    
    @IBAction func lerProjeto(sender: AnyObject) {
        
        if let proposicao = self.proposicao,
            let urlString = proposicao.urlInteiroTeor,
            let url = NSURL(string: urlString){
            
            UIApplication.sharedApplication().openURL(url) //Opens Safari to show the file
        }else{
            print("error")
            //TODO: Error message
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
