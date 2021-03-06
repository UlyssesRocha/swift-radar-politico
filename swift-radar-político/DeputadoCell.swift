//
//  DeputadoCell.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/29/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DeputadoCell: UITableViewCell {

    @IBOutlet weak var seguindoSwitch: UISwitch!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var partidoLabel: UILabel!
    @IBOutlet weak var fotoImage: UIImageView!
    private var deputado:CDDeputado?

    
    @IBAction func seguirSwitch(sender: AnyObject) {

        if self.deputado == nil{
            return
        }
        
        if seguindoSwitch.on == false{
            DeputadosDataController.sharedInstance.unfollowDeputadoWithId(Int(self.deputado!.ideCadastro))
        }else{
            DeputadosDataController.sharedInstance.followDeputadoWithId(Int(self.deputado!.ideCadastro))
        }
    }
    
    
    func loadWithDeputado(deputado:CDDeputado){
        
        self.deputado = deputado
        
        self.nomeLabel.text = self.deputado?.nomeParlamentar.capitalizedString
        let suplenteSufix = (self.deputado!.condicao! != "Titular" ? " - "+self.deputado!.condicao : "")
        self.partidoLabel.text = (self.deputado?.partido)!+" - "+(self.deputado?.uf)!+suplenteSufix
        
        self.fotoImage.layer.cornerRadius = 15;
        self.fotoImage.layer.masksToBounds = true
        self.fotoImage.layer.borderWidth = 1.0
        self.fotoImage.layer.borderColor = UIColor(netHex: Constants.green).CGColor
        self.deputado?.loadPhoto(self.fotoImage)
        
        if DeputadosDataController.sharedInstance.isDeputadoFoollowed(Int(self.deputado!.ideCadastro)){
            self.seguindoSwitch.on = true
        }
    }
    
    override func awakeFromNib(){
        
        self.seguindoSwitch.onImage = UIImage(named: "Unfollow")
        self.seguindoSwitch.offImage = UIImage(named: "Follow")
    }
    
    override func prepareForReuse() {
        
        self.deputado = nil
        self.fotoImage.image = nil
        self.seguindoSwitch.on = false
    }


}
