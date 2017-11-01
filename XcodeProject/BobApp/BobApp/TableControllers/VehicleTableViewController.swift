//
//  VehicleTableViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 26/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class VehicleTableViewController: UITableViewController {
    //MARK: Properties
    var vehicles = VehiclesDatabase.instance.getVehicles()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicles = VehiclesDatabase.instance.getVehicles()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        vehicles = VehiclesDatabase.instance.getVehicles()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "VehicleTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VehicleTableViewCell  else {
            fatalError("The dequeued cell is not an instance of VehicleTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let vehicle = vehicles[indexPath.row]
        //VehiclesDatabase.instance.deleteVehicle(vid: 1)
        cell.vehicleNameLabel.text = vehicle.first_name
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // action one
//        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
//            print("Edit tapped")
//        })
//        editAction.backgroundColor = UIColor.blue
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            if let cell = tableView.cellForRow(at: indexPath) as? VehicleTableViewCell {
                
            }
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction]
    }
}

