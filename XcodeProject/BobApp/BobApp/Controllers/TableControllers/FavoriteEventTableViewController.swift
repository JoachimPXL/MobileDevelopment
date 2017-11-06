//
//  FavoriteEventTableViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 06/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class FavoriteEventTableViewController: UITableViewController {
    var favorites: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favorites.append(Event(name: "Testevent", attending: 90,afstand: 90.10))
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
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FavoriteEventCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteUITableViewCell  else {
            fatalError("The dequeued cell is not an instance of FavoriteEventCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let event = favorites[indexPath.row]
        //VehiclesDatabase.instance.deleteVehicle(vid: 1)
        cell.eventNam.text = "\(event.name)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "\u{267A}\n Verwijder") { action, index in
            //verwijderen uit favorieten.
            //tableView.reloadData()
        }
        
        return [delete]
    }
    
}
