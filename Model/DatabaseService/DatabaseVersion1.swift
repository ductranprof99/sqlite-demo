//
//  DatabaseVersion1.swift
//  DemoSQL
//
//  Created by Duc Tran on 08/02/2023.
//

import Foundation
import SQLite
import SQLite3

final class DatabaseActionVersion1: DatabaseActionVersionProtocol {
    func getAllValue(typeId: String) -> [any Updatable] {
        if typeId == WalletV1.tableIdentifier {
            guard let queryResults = try? self.connection?.run("SELECT * FROM wallet") else {
                print("error")
                return []
            }
            var arr : [WalletV1] = []
            
            for wallet in queryResults {
                let id = Int(wallet[0] as! Int64)
                let address = wallet[1] as! String
                let balance = Int(wallet[2] as! Int64)
                let pending = Int(wallet[3] as! Int64)
                arr += [WalletV1(id: id, address: address, balance: balance, pendingBalance: pending)]
            }
            
            return arr
        }
        return []
    }
    
    typealias T = Updatable
    
    var tables: [String : Table] = [:]
    
    var connection: SQLite.Connection?
    
    var dbPath: String {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentDirectory!.appendingPathComponent("db.version1").path
    }
    
    internal func checkExist() -> Bool {
        guard let fileURL = URL(string: dbPath) else { return false }
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            // database does not exist, create it
            return false
        } else {
            // database exists, do not create it again
            return true
        }
    }
    
    func create() {
        
        let db = try? Connection(dbPath)
        let wallets = Table(WalletV1.tableIdentifier)
        let id = Expression<Int>("id")
        let address = Expression<String>("address")
        let balance = Expression<Int>("balance")
        let pendingBalance = Expression<Int>("pendingBalance")
        tables[WalletV1.tableIdentifier] = wallets
        

        let transactions = Table("transactions")
        let hash = Expression<String>("hash")
        let toAddress = Expression<String>("toAddress")
        let pubKey = Expression<String>("pubKey")
        let amount = Expression<Int>("amount")
        let pendingUse = Expression<Int>("pendingUse")
        let fee = Expression<Int>("fee")
        let tip = Expression<Int>("tip")
        let message = Expression<String>("message")
        let time = Expression<Int>("time")
        let status = Expression<Int>("status")
        let type = Expression<String>("type")
        let prevHash = Expression<String>("prevHash")
        let sign = Expression<String>("sign")
        let receive_info = Expression<String>("receive_info")
        let isDeploy = Expression<Int>("isDeploy")
        let isCall = Expression<Int>("isCall")
        let functionCall = Expression<String>("functionCall")
        tables[TransactionV1.tableIdentifier] = transactions
        
        if checkExist() {
            connection = try? Connection(dbPath)
            return
        } else {
            do {
                try db?.run(wallets.create { t in
                    t.column(id, primaryKey: true)
                    t.column(address)
                    t.column(balance)
                    t.column(pendingBalance)
                })
                
            } catch {
                NSLog("Data base create error")
            }
            
            do {
                try db?.run(transactions.create { t in
                    t.column(id, primaryKey: true)
                    t.column(hash)
                    t.column(address)
                    t.column(toAddress)
                    t.column(pubKey)
                    t.column(amount)
                    t.column(pendingUse)
                    t.column(balance)
                    t.column(fee)
                    t.column(tip)
                    t.column(message)
                    t.column(time)
                    t.column(status)
                    t.column(type)
                    t.column(prevHash)
                    t.column(sign)
                    t.column(receive_info)
                    t.column(isDeploy)
                    t.column(isCall)
                    t.column(functionCall)
                })
                
            } catch {
                NSLog("Data base create error")
            }
            self.connection = db
            try? self.connection?.backup(usingConnection: self.connection ?? .init())
        }
    }
    
    func insert(tableIdentifier: String, object: any T) {
        guard let connection = connection,
              let table = tables[tableIdentifier] else { return }
        do {
            if let wallet = object as? WalletV1 {
                let insert = table.insert(wallet.insertExpression)
                try connection.run(insert)
            }
        } catch {
            NSLog("Database update fail")
        }
    }
    
    func update(tableIdentifier: String, object: any T) {
        guard let connection = connection,
              let table = tables[tableIdentifier] else { return }
        do {
            try connection.run(table.filter(object.idExpression == object.id).update(object.updateExpressions))
            
        } catch {
            NSLog("Database update fail")
        }
    }
    
    func migrate() {
        
    }
    
    func delete(object: any T) {
        do {
            try connection?.run(object.deleteExpressions)
        } catch {
            NSLog("Database update fail")
        }
    }
    
    func erase() {
        do {
            guard let url = URL(string: dbPath) else { return }
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Failed to erase database: \(error)")
        }
    }
    
}

