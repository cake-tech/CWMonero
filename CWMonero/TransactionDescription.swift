import Foundation
import CWCore

public struct TransactionDescription {
    public let id: String
    public let date: Date
    public let totalAmount: Amount
    public let fee: Amount
    public let direction: TransactionDirection
    public let priority: TransactionPriority
    public let status: TransactionStatus
    public let isPending: Bool
    public let height: UInt64
    public let paymentId: String
    
    public init(
        id: String,
        date: Date,
        totalAmount: Amount,
        fee: Amount,
        direction: TransactionDirection,
        priority: TransactionPriority,
        status: TransactionStatus,
        isPending: Bool,
        height: UInt64,
        paymentId: String) {
        self.id = id
        self.date = date
        self.totalAmount = totalAmount
        self.fee = fee
        self.direction = direction
        self.priority = priority
        self.status = status
        self.isPending = isPending
        self.height = height
        self.paymentId = paymentId
    }
}

extension TransactionDescription: Equatable {
    public static func ==(lhs: TransactionDescription, rhs: TransactionDescription) -> Bool {
        return lhs.id == rhs.id
            && lhs.status == rhs.status
            && lhs.isPending == rhs.isPending
            && lhs.date == rhs.date
    }
}
