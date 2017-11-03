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
//        VehiclesDatabase.instance.addVehicle( vfirst_name: "Test", vlast_name: "lastTest", vdateOfBirth: Date(timeIntervalSinceReferenceDate: -123456789.0), vmeetupLocation: "Lummen", vdepartureToEvent: "21:00", vdepartureAtEvent: "03:00", vdescription: "Opel Astra - zwart", vphoneNumber: "0492600330")
        refreshDataInTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        refreshDataInTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddPassengerIdentifier") {
            if let navigationViewController = segue.destination as? UINavigationController {
                let addPassengerViewController = navigationViewController.topViewController as! AddPassengerViewController;
                addPassengerViewController.vehicleId = 1 //nog aanpassen zodat het vehicle id worth meegegeven.
            }
        }
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
        print(vehicle.id)
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
            print("Delete button tapped")
            VehiclesDatabase.instance.deleteVehicle(vid: Int64(indexPath.row + 1))
            self.refreshDataInTableView()
        }
        
        let ride = UITableViewRowAction(style: .default, title: "\u{21D2}\n Rij mee") { action, index in
            print("ride button tapped")
            self.performSegue(withIdentifier: "AddPassengerIdentifier", sender: nil)
        }
        ride.backgroundColor = UIColor.green
        return [ride, delete]
    }
    
    func refreshDataInTableView() {
        tableView.reloadData()
        vehicles = VehiclesDatabase.instance.getVehicles()
        tableView.reloadData()
    }
}

