//
//  ProposicaoTableViewCell.swift
//  swift-radar-político
//
//  Created by Ulysses on 3/16/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class ProposicaoTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var summaryProposicao: UITextView!
    
    @IBOutlet weak var objectOfLastVote: UITextView!
    @IBOutlet weak var summaryLastVote: UITextView!
}
