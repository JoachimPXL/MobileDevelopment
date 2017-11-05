//
//  EventTableViewController.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 28/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    
    var mappedEvents2: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.reloadData()
        mappedEvents2.append(Event(name: "Testevent", attending: 90,afstand: 90.10))
        print("ZIT IN EVENT VIEW CONTROLLER")
//        let otherVC = PulsatorViewController()
        //mappedEvents2 = otherVC.mappedEvents
        print(mappedEvents2.count)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mappedEvents2.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventUITableViewCell  else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell.")
        }

        // Fetches the appropriate meal for the data source layout.
        let event = mappedEvents2[indexPath.row]
        //VehiclesDatabase.instance.deleteVehicle(vid: 1)
        cell.eventName.text = "\(event.name)"

        return cell
    }
    
}

