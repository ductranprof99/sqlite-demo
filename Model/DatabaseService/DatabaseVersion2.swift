////
////  DatabaseVersion2.swift
////  DemoSQL
////
////  Created by Duc Tran on 08/02/2023.
////
//
//import Foundation
//import SQLite
//
//final class DatabaseActionVersion2: DatabaseActionVersionProtocol {
//    func getAllValue(typeId: String) -> [any Updatable] {
//        if typeId == WalletV1.tableIdentifier {
//            guard let queryResults = try? self.connection?.run("SELECT * FROM wallet") else {
//                print("error")
//                return []
//            }
//            var arr : [WalletV1] = []
//
//            for wallet in queryResults {
//                let id = wallet[0] as! Int
//                let address = wallet[2] as! String
//                let balance = wallet[1] as! Int
//                let pending = wallet[3] as! Int
//                arr += [WalletV1(id: id, address: address, balance: balance, pendingBalance: pending)]
//            }
//
//            return arr
//        }
//        return []
//    }
//
//    typealias T = Updatable
//
//    var tables: [String : Table] = [:]
//
//    var connection: SQLite.Connection?
//
//    var dbPath: String {
//        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//        return documentDirectory!.appendingPathComponent("db.version1").path
//    }
//
//    internal func checkExist() -> Bool {
//        guard let fileURL = URL(string: dbPath) else { return false }
//        if !FileManager.default.fileExists(atPath: fileURL.path) {
//            // database does not exist, create it
//            return false
//        } else {
//            // database exists, do not create it again
//            return true
//        }
//    }
//
//    func create() {
//
//        let db = try? Connection(dbPath)
//        let wallets = Table(WalletV1.tableIdentifier)
//
//        tables[WalletV1.tableIdentifier] = wallets
//
//
//        let transactions = Table("transactions")
//
//        tables[TransactionV1.tableIdentifier] = transactions
//
//        if checkExist() {
//            connection = try? Connection(dbPath)
//            return
//        } else {
//            do {
//                try db?.run(wallets.create { t in
//
//                })
//
//            } catch {
//                NSLog("Data base create error")
//            }
//
//            do {
//                try db?.run(transactions.create { t in
//
//                })
//
//            } catch {
//                NSLog("Data base create error")
//            }
//            self.connection = db
//            try? self.connection?.backup(usingConnection: self.connection ?? .init())
//        }
//    }
//
//
//    func update(tableIdentifier: String, object: any T) {
//        guard let connection = connection,
//              let table = tables[tableIdentifier] else { return }
//        do {
//            try connection.run(table.filter(object.idExpression == object.id).update(object.updateExpressions))
//        } catch {
//            NSLog("Database update fail")
//        }
//    }
//
//    func migrate() {
//
//    }
//
//    func delete(object: any T) {
//        do {
//            try connection?.run(object.deleteExpressions)
//        } catch {
//            NSLog("Database update fail")
//        }
//    }
//
//    func erase() {
//        do {
//            guard let url = URL(string: dbPath) else { return }
//            try FileManager.default.removeItem(at: url)
//        } catch {
//            print("Failed to erase database: \(error)")
//        }
//    }
//
//}
//
