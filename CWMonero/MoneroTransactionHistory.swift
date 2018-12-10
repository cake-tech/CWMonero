import Foundation
import CWCore

public final class MoneroTransactionHistory: TransactionHistory {
    public var transactions: [TransactionDescription] {
        return transactionHisory.getAll().map { TransactionDescription(moneroTransactionInfo: $0) }
    }
    public var count: Int {
        return Int(self.transactionHisory.count())
    }
    private(set) var transactionHisory: MoneroWalletHistoryAdapter
    
    public init(moneroWalletHistoryAdapter: MoneroWalletHistoryAdapter) {
        self.transactionHisory = moneroWalletHistoryAdapter
    }
    
    public func refresh() {
        self.transactionHisory.refresh()
    }
    
    public func newTransactions(afterIndex index: Int) -> [TransactionDescription] {
        guard index >=   0 else {
            return []
        }
        
        let endIndex = count - index
        var transactions = [TransactionDescription]()
        
        for i in index..<endIndex {
            transactions.append(TransactionDescription(moneroTransactionInfo: transactionHisory.transaction(Int32(i))))
        }
        
        return transactions
    }
}

extension TransactionDescription {
    public init(moneroTransactionInfo: MoneroTransactionInfoAdapter) {
        self.init(
            id: moneroTransactionInfo.hash(),
            date: Date(timeIntervalSince1970: moneroTransactionInfo.timestamp()),
            totalAmount: MoneroAmount(value: moneroTransactionInfo.amount()),
            fee: MoneroAmount(value: moneroTransactionInfo.fee()),
            direction: moneroTransactionInfo.direction() != 0 ? .outcoming : .incoming,
            priority: .default,
            status: .ok,
            isPending: moneroTransactionInfo.blockHeight() <= 0,
            height: moneroTransactionInfo.blockHeight(),
            paymentId: moneroTransactionInfo.paymentId()
        )
    }
}
