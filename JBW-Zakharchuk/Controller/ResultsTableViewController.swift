//
//  ResultsTableTableViewController.swift
//  JBW-Zakharchuk
//
//  Created by Kateryna Zakharchuk on 3/1/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    var story: Text!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        story.createDictionary()
        story.sortDictionary()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return story.countChar.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoTableViewCell {
            cell.setKeyInfo(dic: self.story.countChar, key: self.story.sortedKeys[indexPath.row])
            if indexPath.row % 2 == 0 {
                cell.contentView.backgroundColor = UIColor(red:0.88, green:0.93, blue:0.98, alpha:1.0)
            } else {
                cell.contentView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
            }
            return cell
        }
        return UITableViewCell()
    }
}
