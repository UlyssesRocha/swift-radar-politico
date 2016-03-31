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
    @IBOutlet weak var descricaoProposicaoText: UITextView!
    @IBOutlet weak var objetoVotacaoText: UITextView!
    
    func loadWithProposicao(proposicao:CDProposicao,votacao:CDVotacao){
        
        self.nomeProposicaoLabel.text = proposicao.nome
        
        self.descricaoProposicaoText.text = proposicao.ementa
        self.objetoVotacaoText.text = votacao.objVotacao
        self.descricaoProposicaoText.scrollRectToVisible(CGRect(x: 0,y: 0,width: 0,height: 0), animated: false)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        
        self.dataVotacaoLabel.text  = dateFormatter.stringFromDate(votacao.data)
        
        self.setNeedsLayout()
        self.setNeedsUpdateConstraints()
    }
    
}
