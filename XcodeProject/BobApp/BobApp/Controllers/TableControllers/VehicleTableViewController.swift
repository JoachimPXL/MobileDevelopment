//
//  VehicleTableViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 26/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class VehicleTableViewController: UITableViewController {
    
    var vehicles = VehiclesDatabase.instance.getVehicles()
    var selectedRowId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshDataInTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        refreshDataInTableView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "VehicleTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VehicleTableViewCell  else {
            fatalError("The dequeued cell is not an instance of VehicleTableViewCell.")
        }
        
        let vehicle = vehicles[indexPath.row]
        cell.bobFullName.text = vehicle.first_name + " " + vehicle.last_name
        cell.meetupLocation.text = vehicle.meetupLocation
        cell.departureTimeToEvent.text = vehicle.departureToEvent
        cell.departureTimeAtEvent.text = vehicle.departureAtEvent
        cell.carDescription.text = vehicle.description
        cell.phoneNumber.text = vehicle.phoneNumber
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "\u{267A}\n Verwijder") { action, index in
            VehiclesDatabase.instance.deleteVehicle(vid: Int64(indexPath.row + 1))
            PassengersDatabase.instance.deletePassengersFromVehicle(vVehicleId: Int64(indexPath.row + 1))
            self.refreshDataInTableView()
        }
        
        let ride = UITableViewRowAction(style: .default, title: "\u{21D2}\n Rij mee") { action, index in
            self.selectedRowId = indexPath.row + 1
            let amountOfPassengers = PassengersDatabase.instance.getPassengersCountByVehicleId(vVehicleId: Int64(indexPath.row + 1))
            let foundVehicle = VehiclesDatabase.instance.getVehicleById(vId: indexPath.row + 1)
            let capacityInVehicle = foundVehicle.capacity
            
            if(amountOfPassengers < capacityInVehicle) {
                print(amountOfPassengers)
                print(capacityInVehicle)
                self.performSegue(withIdentifier: "AddPassengerIdentifier", sender: nil)
            } else {
                let alertController = UIAlertController(title: "Volle wagen", message:
                    "Kies aub een nieuwe bob!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Annuleer", style: UIAlertActionStyle.destructive,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        ride.backgroundColor = UIColor.green
        
        return [ride, delete]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddPassengerIdentifier") {
            if let navigationViewController = segue.destination as? UINavigationController {
                let addPassengerViewController = navigationViewController.topViewController as! AddPassengerViewController;
                addPassengerViewController.vehicleId = self.selectedRowId
            }
        }
    }
    
    func refreshDataInTableView() {
        tableView.reloadData()
        vehicles = VehiclesDatabase.instance.getVehicles()
        tableView.reloadData()
    }
}

