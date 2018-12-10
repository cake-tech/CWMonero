import Foundation
import CWCore

public protocol TransactionHistory {
    var count: Int { get }
    var transactions: [TransactionDescription] { get }
    
    func newTransactions(afterIndex index: Int) -> [TransactionDescription]
    func refresh()
}

