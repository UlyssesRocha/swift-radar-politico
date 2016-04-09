//
//  ConteudoCell.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/28/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class ConteudoCell: UITableViewCell {

    @IBOutlet weak var nomeProposicaoLabel: UILabel!
    @IBOutlet weak var dataVotacaoLabel: UILabel!
    @IBOutlet weak var objetoVotacaoText: UILabel!
    @IBOutlet weak var descricaoProposicaoText: UILabel!
    
    
    func loadWithProposicao(proposicao:CDProposicao,votacao:CDVotacao){
        
        self.nomeProposicaoLabel.text = proposicao.nome
        
        self.descricaoProposicaoText.text = proposicao.ementa
        self.objetoVotacaoText.text = votacao.objVotacao
        
        self.dataVotacaoLabel.text  = votacao.data.getFormatedDateString()
        
        self.setNeedsLayout()
        self.setNeedsUpdateConstraints()
    }
}
