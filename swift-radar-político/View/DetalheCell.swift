//
//  DetalheCell.swift
//  swift-radar-político
//
//  Created by Ulysses on 4/2/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DetalheCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!

    @IBOutlet weak var dataText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
