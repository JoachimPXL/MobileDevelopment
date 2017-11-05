//
//  VehiclesDatabase.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 29/10/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import SQLite

class VehiclesDatabase {
    static let instance = VehiclesDatabase()
    private let db: Connection?
    private let vehicles = Table("Bobs")
    private let id = Expression<Int64>("id")
    private let first_name = Expression<String>("first_name")
    private let last_name = Expression<String>("last_name")
    private let dateOfBirth = Expression<Date>("dateOfBirth")
    private let meetupLocation = Expression<String>("meetupLocation")
    private let departureToEvent = Expression<String>("departureToEvent")
    private let departureAtEvent = Expression<String>("departureAtEvent")
    private let description = Expression<String>("description")
    private let phoneNumber = Expression<String>("phoneNumber")
    private let capacity = Expression<Int>("capacity")
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains (
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/Stephencelis.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        self.createTable()
    }
    
    func createTable() {
        do {
            try db!.run(vehicles.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(first_name)
                table.column(last_name)
                table.column(dateOfBirth)
                table.column(meetupLocation)
                table.column(departureToEvent)
                table.column(departureAtEvent)
                table.column(description)
                table.column(phoneNumber)
                table.column(capacity)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func getVehicles() -> [Vehicle] {
        var vehicles = [Vehicle]()
        
        do {
            for vehicle in try db!.prepare(self.vehicles) {
                vehicles.append(Vehicle(
                    id: vehicle[id],
                    first_name: vehicle[first_name],
                    last_name: vehicle[last_name],
                    dateOfBirth: vehicle[dateOfBirth],
                    meetupLocation: vehicle[meetupLocation],
                    departureToEvent: vehicle[departureToEvent],
                    departureAtEvent: vehicle[departureAtEvent],
                    description: vehicle[description],
                    phoneNumber: vehicle[phoneNumber],
                    capacity: vehicle[capacity]))
            }
        } catch {
            print("Select failed")
        }
        
        return vehicles
        
    }
    
    func getVehicleById(vId: Int) -> Vehicle {
        var foundVehicle: Vehicle
        foundVehicle = (Vehicle(
            id: -1,
            first_name: "",
            last_name: "",
            dateOfBirth: Date(timeIntervalSinceReferenceDate: -123456789.0),
            meetupLocation: "",
            departureToEvent: "",
            departureAtEvent: "",
            description: "",
            phoneNumber: "",
            capacity: -1))
        do {
            for vehicle in try db!.prepare(self.vehicles) {
                if(vehicle[id] == vId) {
                    foundVehicle = (Vehicle(
                    id: vehicle[id],
                    first_name: vehicle[first_name],
                    last_name: vehicle[last_name],
                    dateOfBirth: vehicle[dateOfBirth],
                    meetupLocation: vehicle[meetupLocation],
                    departureToEvent: vehicle[departureToEvent],
                    departureAtEvent: vehicle[departureAtEvent],
                    description: vehicle[description],
                    phoneNumber: vehicle[phoneNumber],
                    capacity: vehicle[capacity]))
                }
            }
        } catch {
            print("Select failed")
        }
       return foundVehicle
    }
    
    func addVehicle(vfirst_name: String, vlast_name: String, vdateOfBirth: Date, vmeetupLocation: String, vdepartureToEvent: String, vdepartureAtEvent: String,
                    vdescription: String, vphoneNumber: String, vcapacity: Int) -> Int64? {
        do {
            let insert = vehicles.insert(first_name <- vfirst_name, last_name <- vlast_name, dateOfBirth <- vdateOfBirth, meetupLocation <- vmeetupLocation,
                                         departureToEvent <- vdepartureToEvent, departureAtEvent <- vdepartureAtEvent, description <- vdescription, phoneNumber <- vphoneNumber, capacity <- vcapacity)
            let id = try db!.run(insert)
            print(insert.asSQL())
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    func deleteVehicle(vid: Int64) -> Bool {
        do {
            let vehicle = vehicles.filter(id == vid)
            try db!.run(vehicle.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    func updateVehicle(vid:Int64, newVehicle: Vehicle) -> Bool {
        let vehicle = vehicles.filter(id == vid)
        do {
            let update = vehicle.update([
                first_name <- newVehicle.first_name,
                last_name <- newVehicle.last_name,
                dateOfBirth <- newVehicle.dateOfBirth,
                meetupLocation <- newVehicle.meetupLocation,
                departureToEvent <- newVehicle.departureToEvent,
                departureAtEvent <- newVehicle.departureAtEvent,
                description <- newVehicle.description,
                phoneNumber <- newVehicle.phoneNumber,
                capacity <- newVehicle.capacity
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }

}
