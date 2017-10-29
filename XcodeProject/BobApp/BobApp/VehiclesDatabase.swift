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
    
    private let vehicles = Table("vehicles")
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    
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
        
        createTable()
    }
    
    func createTable() {
        do {
            try db!.run(vehicles.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
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
                    name: vehicle[name]))
            }
        } catch {
            print("Select failed")
        }
        
        return vehicles
        
    }
    
    func addVehicle(vname: String) -> Int64? {
        do {
            let insert = vehicles.insert(name <- vname)
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
                name <- newVehicle.name])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }

}
