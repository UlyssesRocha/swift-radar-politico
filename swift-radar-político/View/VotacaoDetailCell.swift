//
//  VotacaoDetailCell.swift
//  swift-radar-político
//
//  Created by Ulysses on 4/10/16.
//  Copyright © 2016 Dados Abertos Brasil. All rights reserved.
//

import UIKit

class VotacaoDetailCell: UITableViewCell {

    @IBOutlet weak var objetoVotacaoLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var resumoVotacaoLabel: UILabel!
    
    
    var votacao:CDVotacao?
    
    func loadWithVotaocao(votacao:CDVotacao){
        self.votacao = votacao
        
        self.objetoVotacaoLabel.text = votacao.objVotacao
        self.dataLabel.text  = votacao.data.getFormatedDateString()
        self.resumoVotacaoLabel.text = votacao.resumo
    }

}
