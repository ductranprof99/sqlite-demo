//
//  DatabaseCreate.swift
//  DemoSQL
//
//  Created by Duc Tran on 08/02/2023.
//

import Foundation
import SQLite

protocol Updatable {
    associatedtype ObjectType
    var idExpression: Expression<Int> { get }
    var id: Int { get set }
    var insertExpression: [Setter] { get }
    var updateExpressions: [Setter] { get }
    var deleteExpressions: String { get }
    static var tableIdentifier: String { get }
}

protocol DatabaseActionVersionProtocol {
   
    var connection: Connection? { get set }
    
    associatedtype T
    var tables: [String: Table] { get set }
    var dbPath: String { get }
    
    // MARK: Table ultility
    func checkExist() -> Bool
    
    // MARK: Table management
    func create()
    func insert(tableIdentifier: String, object: T)
    func update(tableIdentifier: String, object: T)
    func getAllValue(typeId: String) -> [any Updatable]
    func migrate()
    func delete(object: T)
    func erase()
}

protocol DatabaseProtocol {
    var databaseActionVersion: any DatabaseActionVersionProtocol { get set }
}

final class Database: DatabaseProtocol {
    static let version1: DatabaseProtocol = Database.init(DatabaseActionVersion1())
//    static let version2: DatabaseProtocol = Database.init()
//    static let version3: DatabaseProtocol = Database.init()
 
    var databaseActionVersion: any DatabaseActionVersionProtocol
    
    init(_ databaseActionVersion: any DatabaseActionVersionProtocol) {
        self.databaseActionVersion = databaseActionVersion
        self.databaseActionVersion.create()
    }
}
