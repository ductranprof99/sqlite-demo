//
//  Version1.swift
//  DemoSQL
//
//  Created by Duc Tran on 08/02/2023.
//

import Foundation
import SQLite


// MARK: - wallet table
final class WalletV1 {
    
    var id: Int
    var address: String
    var balance: Int
    var pendingBalance: Int
    
    init(id: Int, address: String, balance: Int, pendingBalance: Int) {
        self.id = id
        self.address = address
        self.balance = balance
        self.pendingBalance = pendingBalance
    }
}

extension WalletV1: Updatable {
    var deleteExpressions: String {
        return "DELETE FROM \(WalletV1.tableIdentifier) WHERE id = \(id)"
    }
    
    static var tableIdentifier: String {
        get {
            "wallet"
        }
    }
    
    typealias ObjectType = WalletV1
    var idExpression: Expression<Int> { return Expression<Int>("id") }
    
    var updateExpressions: [Setter] {
        return [Expression<Int>("balance") <- balance,
                Expression<Int>("pendingBalance") <- pendingBalance]
    }
    
    var insertExpression: [Setter] {
        let id = Expression<Int>("id")
        let address = Expression<String>("address")
        let balance = Expression<Int>("balance")
        let pendingBalance = Expression<Int>("pendingBalance")
        return [id <- self.id,
                address <- self.address,
                balance <- self.balance,
                pendingBalance <- self.pendingBalance]
    }
}

// MARK: - transaction table

final class TransactionV1 {
    
    var id: Int
    var hash: String
    var address: String
    var toAddress: String
    var pubKey: String
    var amount: Int
    var pendingUse: Int
    var balance: Int
    var fee: Int
    var tip: Int
    var message: String
    var time: Int
    var status: Int
    var type: String
    var prevHash: String
    var sign: String
    var receive_info: String
    var isDeploy: Int
    var isCall: Int
    var functionCall: String
    
    init(id: Int, hash: String, address: String, toAddress: String, pubKey: String, amount: Int, pendingUse: Int, balance: Int, fee: Int, tip: Int, message: String, time: Int, status: Int, type: String, prevHash: String, sign: String, receive_info: String, isDeploy: Int, isCall: Int, functionCall: String) {
        self.id = id
        self.hash = hash
        self.address = address
        self.toAddress = toAddress
        self.pubKey = pubKey
        self.amount = amount
        self.pendingUse = pendingUse
        self.balance = balance
        self.fee = fee
        self.tip = tip
        self.message = message
        self.time = time
        self.status = status
        self.type = type
        self.prevHash = prevHash
        self.sign = sign
        self.receive_info = receive_info
        self.isDeploy = isDeploy
        self.isCall = isCall
        self.functionCall = functionCall
    }
}

extension TransactionV1: Updatable {
    var deleteExpressions: String {
        return "DELETE FROM \(TransactionV1.tableIdentifier) WHERE id = \(self.id)"
    }
    
    var idExpression: Expression<Int> { return Expression<Int>("id") }
    
    var updateExpressions: [Setter] {
        return [Expression<String>("hash") <- hash,
                Expression<String>("toAddress") <- toAddress,
                Expression<String>("pubKey") <- pubKey,
                Expression<Int>("amount") <- amount,
                Expression<Int>("pendingUse") <- pendingUse,
                Expression<Int>("fee") <- fee,
                Expression<Int>("tip") <- tip,
                Expression<String>("message") <- message,
                Expression<Int>("time") <- time,
                Expression<Int>("status") <- status,
                Expression<String>("type") <- type,
                Expression<String>("prevHash") <- prevHash,
                Expression<String>("sign") <- sign,
                Expression<String>("receive_info") <- receive_info,
                Expression<Int>("isDeploy") <- isDeploy,
                Expression<Int>("isCall") <- isCall,
                Expression<String>("functionCall") <- functionCall]
    }
    
    typealias ObjectType = TransactionV1
    
    static var tableIdentifier: String {
        get {
            "transaction"
        }
    }
    
    var insertExpression: [Setter] {
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
        return [
            hash <- self.hash,
            toAddress <- self.toAddress,
            pubKey <- self.pubKey,
            amount <- self.amount,
            pendingUse <- self.pendingUse,
            fee <- self.fee,
            tip <- self.tip,
            message <- self.message,
            time <- self.time,
            status <- self.status,
            type <- self.type,
            prevHash <- self.prevHash,
            sign <- self.sign,
            receive_info <- self.receive_info,
            isDeploy <- self.isDeploy,
            isCall <- self.isCall,
            functionCall <- self.functionCall
        ]
    }
    
}

