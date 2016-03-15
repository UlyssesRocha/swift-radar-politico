//
//  DiarioDataController.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/15/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit


class DiarioDataController: NSObject {
    //Singleton
    static let sharedInstance = DiarioDataController()
    private override init() {}

    //Variables
    private var proposicoes:[CDProposicao] = []
    
    
    
//MARK: Public Functions
    func loadCongressVotedPropositions(){
        
    }
    
//MARK: Private Functions

   private func loadCongressVotedPropositionsFrom(year year:UInt){
        
        CDProposicao.loadDistinctCodProposicoesVotedIn(year, withCompletionHandler: { (votacoes) -> Void in
            for i in votacoes {
                if let prepId = i as? NSString{
                    let proposicao = CDProposicao.init(codProposicao: prepId.integerValue)
                    self.proposicoes.append(proposicao)
                }
            }
            self.loadPreposicaoAtIndex(0)
        })

    }
    

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
                    self.loadPreposicaoAtIndex(index+1)
                })
            }
        })
    }

    
}
