//
//  InfoTableViewCell.swift
//  JBW-Zakharchuk
//
//  Created by Kateryna Zakharchuk on 3/1/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var InfoLabel: UILabel!
    
    func setKeyInfo(dic: Dictionary<Character, Int>, key: Character) {
        InfoLabel.text = "<\"\(key)\" - \(String(describing: dic[key]!)) times>"
        InfoLabel.textColor = UIColor(red:0.05, green:0.15, blue:0.41, alpha:1.0)
    }
}
