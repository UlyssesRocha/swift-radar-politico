//
//  VotacaoCell.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/28/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class VotacaoCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var proposicao:CDProposicao?
    
    
    func loadWithVotacao(proposicao:CDProposicao){
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.proposicao = proposicao
        self.tableView.reloadData()
       
        self.tableView.layer.cornerRadius = 5.0
        self.tableView.clipsToBounds = true
        self.tableView.layer.masksToBounds = true
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  (section == 0 ? 1 : DeputadosDataController.sharedInstance.getNumberOfFollowedDeputados() )
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ConteudoCell", forIndexPath: indexPath) as! ConteudoCell
            cell.loadWithProposicao(proposicao!, votacao: proposicao!.votacoes.last as! CDVotacao)
            return cell
        }
        
        // -- Voto
        let cell = tableView.dequeueReusableCellWithIdentifier("VotoCell", forIndexPath: indexPath)
        if let deputado = DeputadosDataController.sharedInstance.getFollowedDeputadoWith(indexPath.row){
            cell.textLabel!.text = deputado.nomeParlamentar.capitalizedString
            cell.detailTextLabel?.text = self.getVoteFromDeputadoWithName(deputado.nomeParlamentar.capitalizedString, inVotacao: proposicao!.votacoes.last as! CDVotacao)
            cell.roundCorner()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //TODO: Change to dynamic Height
        return indexPath.section == 0 ? 240.0 : 40
    }
    
    private func getVoteFromDeputadoWithName(nomeDeputado:String, inVotacao votacao:CDVotacao)->String{
        
        let votos = votacao.votoDeputados
        //TODO: Improve search
        for i in votos{
            let name = i.objectForKey("Nome") as! String
            if  name.lowercaseString == nomeDeputado.lowercaseString{
                return i.objectForKey("Voto") as! String
            }
        }
        return "Sem Voto"
    }
}

