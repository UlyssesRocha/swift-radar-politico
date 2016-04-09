//
//  DeputadosDataController.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/29/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DeputadosDataController: NSObject {
    //Singleton
    static let sharedInstance = DeputadosDataController()
    
    var deputados:[CDDeputado]?
    
    private var followedDeputadosID:NSMutableSet?
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    private override init() {
        
        super.init()
        
        //Load list of followed deputados
        self.loadFollowedDeputados()
        
        //Load deputados From server
        CDDeputado.loadDeputados { (reponseArray) in
            self.deputados = reponseArray.sort { $0.nomeParlamentar < $1.nomeParlamentar } as? [CDDeputado]
        }
    }
    
    private func saveFollowedDeputados(){
        
        let array = self.followedDeputadosID?.allObjects
        userDefaults.setObject(array, forKey:"followed")
    }
    
    private func loadFollowedDeputados(){
        
        if let deputadosIdArray = userDefaults.objectForKey("followed") as? [Int]{
            self.followedDeputadosID = NSMutableSet(array: deputadosIdArray)
        }else{ //Create
            followedDeputadosID = NSMutableSet()
        }
    }
    
    func isDeputadoFoollowed(deputadoId:Int)->Bool{
        
        return followedDeputadosID!.containsObject(deputadoId)
    }
    
    func followDeputadoWithId(id:Int){
        
        followedDeputadosID!.addObject(id)
        self.saveFollowedDeputados()
    }
    func unfollowDeputadoWithId(id:Int){
        
        followedDeputadosID?.removeObject(Int(id))
        self.saveFollowedDeputados()
    }
    
    func getNumberOfFollowedDeputados()->Int{
        
        return followedDeputadosID!.count
    }
    
    func getFollowedDeputadoWith(index:Int)->CDDeputado?{
        
        if deputados == nil || index > self.getNumberOfFollowedDeputados(){
            return nil
        }
        
        //TODO: Improve Search
        for i in self.deputados!{
            if Int(i.ideCadastro) == Int(self.followedDeputadosID!.allObjects[index] as! NSNumber){
                return i
            }
        }
        
        return nil
    }
}
