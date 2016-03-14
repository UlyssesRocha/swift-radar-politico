//
//  ViewController.swift
//  swift-radar-político
//
//  Created by Francisco José A. C. Souza on 23/02/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import AEXML

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let url = CDURLManager.obterPartidosCD()
//        
//        let partidos = NSData(contentsOfURL: NSURL(string: url)!)
//        
//        do{
//            
//            let dados = try AEXMLDocument(xmlData: partidos!)
//            if let partido = dados.root["partido"].all {
//                for sP in partido {
//                     print(sP["idPartido"].stringValue)
//                }
//            }
//        }catch{
//            
//        }
        
        
        
        CDDeputado.loadDeputados { (deputados) -> Void in
            for i in deputados{
                if let deputado = i as? CDDeputado{
                    print(deputado.nomeParlamentar)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

