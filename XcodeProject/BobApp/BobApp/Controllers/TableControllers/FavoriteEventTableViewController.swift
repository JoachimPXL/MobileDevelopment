//
//  FavoriteEventTableViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 06/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteEventTableViewController: UITableViewController {
    var favorites = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let decoded = UserDefaults.standard.object(forKey: "FavoriteEvents") as? Data
        if decoded == nil {
            favorites = []
        } else {
            favorites = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [Event]
            let defaults = UserDefaults.standard
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: favorites)
            defaults.set(encodedData, forKey: "RestFavoriteEvents")
            tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FavoriteUITableCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteUITableViewCell  else {
            fatalError("The dequeued cell is not an instance of FavoriteUITableCell.")
        }

        let event = favorites[indexPath.row]
        cell.eventName.text = event.name
        cell.eventOrganisator.text = event.organisator
        cell.attenders.text = "Aanwezigen \(event.attending)"
        cell.photoEvent.sd_setImage(with: URL(string: event.profilePicture), placeholderImage: UIImage(named: ""))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "\u{267A}\n Verwijder") { action, index in
            self.favorites.remove(at: indexPath.row)
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "RestFavoriteEvents")
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.favorites)
            defaults.set(encodedData, forKey: "RestFavoriteEvents")
            defaults.synchronize()
            tableView.reloadData()
        }
        return [delete]
    }
    
}
