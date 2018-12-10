import Foundation
import CWCore

public struct PendingTransactionDescription: Equatable {
    public static func == (lhs: PendingTransactionDescription, rhs: PendingTransactionDescription) -> Bool {
        return lhs.id == rhs.id && lhs.amount.compare(with: rhs.amount) && lhs.fee.compare(with: rhs.fee) && lhs.status == rhs.status
    }
    public let id: String
    public let status: TransactionStatus
    public let amount: Amount
    public let fee: Amount
    
    public init(id: String, status: TransactionStatus, amount: Amount, fee: Amount) {
        self.id = id
        self.status = status
        self.amount = amount
        self.fee = fee
    }
}
