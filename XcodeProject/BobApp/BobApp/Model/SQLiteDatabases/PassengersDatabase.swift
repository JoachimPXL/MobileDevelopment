//
//  PassengersDatabase.swift
//  BobApp
//
//  Created by Joachim Zeelmaekers on 04/11/2017.
//  Copyright © 2017 Joachim Zeelmaekers. All rights reserved.
//

import Foundation
import SQLite

class PassengersDatabase {
    static let instance = PassengersDatabase()
    private let db: Connection?
    private let passengers = Table("PassengersTable")
    private let id = Expression<Int64>("id")
    private let first_name = Expression<String>("first_name")
    private let last_name = Expression<String>("last_name")
    private let phoneNumber = Expression<String>("phoneNumber")
    private let others = Expression<String>("others")
    private let vehicleId = Expression<Int64>("vehicleId")
    
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
            try db!.run(passengers.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(first_name)
                table.column(last_name)
                table.column(phoneNumber)
                table.column(others)
                table.column(vehicleId)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func getPassengers() -> [Passenger] {
        var passengers = [Passenger]()
        
        do {
            for passenger in try db!.prepare(self.passengers) {
                passengers.append(Passenger(
                    id: passenger[id],
                    first_name: passenger[first_name],
                    last_name: passenger[last_name],
                    phoneNumber: passenger[phoneNumber],
                    others: passenger[others],
                    vehicleId: passenger[vehicleId]))
            }
        } catch {
            print("Select failed")
        }
        
        return passengers
        
    }
    
    func addPassenger(vFirst_name: String, vLast_name: String, vOthers: String, vPhoneNumber: String, vVehicleId:Int64) -> Int64? {
        do {
            let insert = passengers.insert(first_name <- vFirst_name, last_name <- vLast_name, others <- vOthers, phoneNumber <- vPhoneNumber, vehicleId <- vVehicleId)
            let id = try db!.run(insert)
            print(insert.asSQL())
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    func deletePassenger(vid: Int64) -> Bool {
        do {
            let passenger = passengers.filter(id == vid)
            try db!.run(passenger.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    func deletePassengersFromVehicle(vVehicleId: Int64) -> Bool {
        do {
            let vehicles = passengers.filter(vehicleId == vVehicleId)
            try db!.run(vehicles.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    
    func getPassengersCountByVehicleId(vVehicleId: Int64) -> Int {
        var passengers = [Passenger]()
        do {
            for passenger in try db!.prepare(self.passengers) {
            if(passenger[id] == vVehicleId) {
                passengers.append(Passenger(
                    id: passenger[id],
                    first_name: passenger[first_name],
                    last_name: passenger[last_name],
                    phoneNumber: passenger[phoneNumber],
                    others: passenger[others],
                    vehicleId: passenger[vehicleId]))
                    }
                }
            } catch {
                print("getByIdFailed")
            }
        return passengers.count
        }

}
