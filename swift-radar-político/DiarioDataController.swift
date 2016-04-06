//
//  DiarioDataController.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/15/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit


@objc protocol DiarioDataControllerDelegate{
    func didUpdateData()
    optional func willLoadData()
    optional func didStopLoadData()
    optional func didFailToUpdate()
    optional func noMoreDataAvaliable()
}


class DiarioDataController: NSObject {
    //Singleton
    static let sharedInstance = DiarioDataController()
    
    private override init() {
        super.init()
        
        //load current year data
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        let currentYearInt = (calendar?.component(NSCalendarUnit.Year, fromDate: NSDate()))!

        self.loadCongressVotedPropositionsFrom(year: currentYearInt)
    }
    
    //Delegate
    var delegate:DiarioDataControllerDelegate? = nil
    
    //Variables
    var proposicoes:[CDProposicao] = []
    var lastLoadedProposition:Int = 0

    private var lastLoadYearOfVotes:Int = Int.max
    private var loadingData = false
    private var sizeOfPage:Int = 5 //Number of Propositions Load at "once" in each request
    private var connectionError = false
    
//MARK: Public Functions
    func loadNextPageOfPropositions(){
        if loadingData == false{
            
            self.delegate?.willLoadData?()
            
            loadingData = true
            
            if lastLoadedProposition == proposicoes.count && self.lastLoadYearOfVotes != Int.max{ //Ended of the array, load the year BEFORE!
                print("vou carregar mais meta proposicoes de outros anos \(self.lastLoadYearOfVotes - (self.connectionError == true ? 0 : 1))")
                self.loadCongressVotedPropositionsFrom(year: self.lastLoadYearOfVotes - (self.connectionError == true ? 0 : 1))
            }else{
                print("vou carregar mais proposicoes")
                self.loadProposicaoIn(lastLoadedProposition, endIndex: lastLoadedProposition + sizeOfPage)
            }
        }
    }
    
//MARK: Private Functions

   private func loadCongressVotedPropositionsFrom(year year:Int){
    //To make sure the porposicoesArray will be in descending order, make it impossible to load a year n and then a n+1
        if self.lastLoadYearOfVotes <= year {
            return
        }
    
        CDProposicao.loadDistinctCodProposicoesVotedIn(UInt(year), withCompletionHandler: { [weak self](votacoes) -> Void in
            
            for i in votacoes {
                if let prepId = i as? NSString{ 
                    let proposicao = CDProposicao.init(codProposicao: prepId.integerValue)
                    self?.proposicoes.append(proposicao)
                }
            }
            
            //ERROR LOADING INFORMATION?
            if votacoes.count == 0{
                self?.connectionError = true
                print("Error loading Information, Check for Internet Connection or Server Error")
            }else{
                self?.lastLoadYearOfVotes = year
            }
            
            self?.delegate?.didStopLoadData?()
            self?.loadingData = false
            self?.loadNextPageOfPropositions()
        })
    }
    
    func loadProposicaoIn(var currentIndex:Int, endIndex:Int){
        if currentIndex >= self.proposicoes.count || currentIndex > endIndex{
            self.delegate?.didStopLoadData?()
            self.loadingData = false
            return
        }
        
        print("inicia carregamento proposicao \(proposicoes[currentIndex].idProposicao)")
        proposicoes[currentIndex].loadProposicao({ () -> Void in
            //If Loaded successfully the proposition, load the votes
            if self.proposicoes[currentIndex].nome != nil{
                //If loaded the votes, call the next
                self.proposicoes[currentIndex].loadVotacoes({ [weak self]() -> Void in
                    if let _ = self?.proposicoes[currentIndex].votacoes{
                        currentIndex += 1 // Load the Next !
                    }else{
                        print("erro votacao \(self?.proposicoes[currentIndex].idProposicao) ") //if not, it will try to load the same again.
                    }
                    
                    self?.lastLoadedProposition = currentIndex
                    self?.loadProposicaoIn(currentIndex, endIndex: endIndex)
                    self?.delegate?.didUpdateData()
                })
            }
        })
    }

    
}
