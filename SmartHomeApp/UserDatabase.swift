import Foundation
import SQLite

class UserDatabase {
    public static let shared = UserDatabase()
    
    private var db: Connection? = nil

    private let path = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true).first!

    private enum table {
        static let device           = Table("device")
        static let light            = Table("light")
        static let rollerShutter    = Table("rollerShutter")
        static let heater           = Table("heater")
    }
    
    private enum row {
        static let id           = Expression<Int>("id")
        static let deviceName   = Expression<String>("deviceName")
        static let productType  = Expression<String>("productType")
        static let intensity    = Expression<Int>("intensity")
        static let temperature  = Expression<Int>("temperature")
        static let position     = Expression<Int>("position")
        static let mode         = Expression<String>("mode")
    }
    
    func initData() {
        let dbPath = URL(fileURLWithPath: path).appendingPathComponent("user.db")
        do {
            if !FileManager.default.fileExists(atPath: dbPath.path) {
                db = try Connection("\(path)/user.db")
                createTable()
                fetchData()
            }
            db = try Connection("\(path)/user.db")
        } catch { print("Error: Could not access user.db") }
    }
    
    private func fetchData() {
        if let url = URL(string: "http://storage42.com/modulotest/devices.json") {
            let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
                guard let data = data else { return }
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : JSONSerialization.ReadingOptions()) as? [String : Any], let devices = jsonArray["devices"] as? [Any] {
                        for device in devices {
                            if let light = try? JSONDecoder().decode(Light.self, from: JSONSerialization.data(withJSONObject: device, options: .prettyPrinted)) {
                                insertLight(light: light, completion: {} )
                            }
                            if let rollerShutter = try? JSONDecoder().decode(RollerShutter.self, from: JSONSerialization.data(withJSONObject: device, options: .prettyPrinted)) {
                                insertRollerShutter(rollerShutter: rollerShutter, completion: {} )
                            }
                            if let heater = try? JSONDecoder().decode(Heater.self, from: JSONSerialization.data(withJSONObject: device, options: .prettyPrinted)) {
                                insertHeater(heater: heater, completion: {} )
                            }
                        }
                    }
                } catch {
                    print("decode error \(error)")
                }
            }
            task.resume()
        }
    }
    
    private func createTable() {
        do {
            try db?.run(table.light.create { t in
                t.column(row.id, primaryKey: .autoincrement)
                t.column(row.deviceName)
                t.column(row.productType)
                t.column(row.intensity)
                t.column(row.mode)
            })
        } catch { print("Error: failed on light table create") }
        do {
            try db?.run(table.rollerShutter.create { t in
                t.column(row.id, primaryKey: .autoincrement)
                t.column(row.deviceName)
                t.column(row.productType)
                t.column(row.position)
            })
        } catch { print("Error: failed on rollerShutter table create") }
        do {
            try db?.run(table.heater.create { t in
                t.column(row.id, primaryKey: .autoincrement)
                t.column(row.deviceName)
                t.column(row.productType)
                t.column(row.temperature)
                t.column(row.mode)
            })
        } catch { print("Error: failed on heater table create") }

    }
}

// Light
extension UserDatabase {
    
    func insertLight(light: Light, completion: () -> ()) {
        guard let db = db else { return }
        let insert = table.light.insert(
            row.deviceName <- light.deviceName,
            row.productType <- light.productType,
            row.intensity <- light.intensity,
            row.mode <- light.mode
        )
        do {
            let rowid = try db.run(insert)
            print("UserDatabase: insertLight added to row \(rowid)")
            completion()
        } catch { }
    }

    func updateLightValueById(id: Int, value: Int) {
        guard let db = db else { return }
        do {
            let filter = table.light.filter(Expression<Int>("id") == id)
            try db.run(filter.update(
                row.intensity <- value
            ))
        } catch { }
    }

    func updateLightModeById(id: Int, mode: Bool) {
        guard let db = db else { return }
        do {
            let filter = table.light.filter(Expression<Int>("id") == id)
            try db.run(filter.update(
                row.mode <- mode ? "ON" : "OFF"
            ))
        } catch { }
    }

    func getLights() -> [Light] {
        guard let db = db else { return [] }
        do {
            return try db.prepare(table.light).map { row in
                return try row.decode()
            }
        } catch { }
        return []
    }
}

// Roller Shutter
extension UserDatabase {

    func insertRollerShutter(rollerShutter: RollerShutter, completion: () -> ()) {
        guard let db = db else { return }
        let insert = table.rollerShutter.insert(
            row.deviceName <- rollerShutter.deviceName,
            row.productType <- rollerShutter.productType,
            row.position <- rollerShutter.position
        )
        do {
            let rowid = try db.run(insert)
            print("UserDatabase: insertRollerShutter added to row \(rowid)")
            completion()
        } catch { }
    }
 
    func updateRollerShutterValueById(id: Int, value: Int) {
        guard let db = db else { return }
        do {
            let filter = table.rollerShutter.filter(Expression<Int>("id") == id)
            try db.run(filter.update(
                row.position <- value
            ))
        } catch { }
    }

    func getRollerShutters() -> [RollerShutter] {
        guard let db = db else { return [] }
        do {
            return try db.prepare(table.rollerShutter).map { row in
                return try row.decode()
            }
        } catch { }
        return []
    }
}

// Heater
extension UserDatabase {

    func insertHeater(heater: Heater, completion: () -> ()) {
        guard let db = db else { return }
        let insert = table.heater.insert(
            row.deviceName <- heater.deviceName,
            row.productType <- heater.productType,
            row.temperature <- heater.temperature,
            row.mode <- heater.mode
        )
        do {
            let rowid = try db.run(insert)
            print("UserDatabase: insertHeater added to row \(rowid)")
            completion()
        } catch { }
    }
    
    func updateHeaterValueById(id: Int, value: Int) {
        guard let db = db else { return }
        do {
            let filter = table.heater.filter(Expression<Int>("id") == id)
            try db.run(filter.update(
                row.temperature <- value
            ))
        } catch { }
    }

    func updateHeaterModeById(id: Int, mode: Bool) {
        guard let db = db else { return }
        do {
            let filter = table.heater.filter(Expression<Int>("id") == id)
            try db.run(filter.update(
                row.mode <- mode ? "ON" : "OFF"
            ))
        } catch { }
    }

    func getHeaters() -> [Heater] {
        guard let db = db else { return [] }
        do {
            return try db.prepare(table.heater).map { row in
                return try row.decode()
            }
        } catch { }
        return []
    }
}
