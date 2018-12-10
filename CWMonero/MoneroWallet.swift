import Foundation
import CWCore

public final class MoneroWallet: Wallet {
    public static let walletType = WalletType.monero
    
    public var name: String {
        return moneroAdapter.name()
    }
    
    public var balance: Amount {
        return MoneroAmount(value: moneroAdapter.balance())
    }
    
    public var unlockedBalance: Amount {
        return MoneroAmount(value: moneroAdapter.unlockedBalance())
    }
    
    public var address: String {
        return moneroAdapter.address()
    }
    
    public var seed: String {
        return moneroAdapter.seed()
    }
    
    public var isConnected: Bool {
        return moneroAdapter.connectionStatus() != 0
    }
    
    public var keys: WalletKeys {
        return _keys
    }
    
    public var isWatchOnly: Bool {
        return _keys.spendKey.sec.range(of: "^0*$", options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    public var currentHeight: UInt64 {
        return moneroAdapter.currentHeight()
    }
    
    public var onNewBlock: ((UInt64) -> Void)?
    public var onBalanceChange: ((Wallet) -> Void)?
    public var onConnectionStatusChange: ((ConnectionStatus) -> Void)?
    public var onSynced: (() -> Void)?
    private var isBlocking: Bool
    
    private var moneroTransactionHistory: MoneroTransactionHistory?
    
    private var _keys: MoneroWalletKeys {
        return MoneroWalletKeys(
            spendKey: MoneroWalletKeysPair(pub: self.moneroAdapter.publicSpendKey(), sec: self.moneroAdapter.secretSpendKey()),
            viewKey: MoneroWalletKeysPair(pub: self.moneroAdapter.publicViewKey(), sec: self.moneroAdapter.secretViewKey()))
    }
    
    private var moneroAdapter: MoneroWalletAdapter
    private var restoreHeight: UInt64
    
    public init(moneroAdapter: MoneroWalletAdapter) {
        self.moneroAdapter = moneroAdapter
        self.isBlocking = false
        restoreHeight = 0
        self.moneroAdapter.delegate = self
    }
    
    public func blockchainHeight() throws -> UInt64 {
        return moneroAdapter.daemonBlockChainHeight()
    }
    
    public func changePassword(newPassword: String) throws {
        try moneroAdapter.setPassword(newPassword)
    }
    
    public func save() throws {
        guard !isBlocking else {
            return
        }
        
        try moneroAdapter.save()
    }
    
    public func connect(to uri: String, login: String, password: String) throws {
        moneroAdapter.setDaemonAddress(uri, login: login, password: password)
        try moneroAdapter.connectToDaemon()
    }
    
    public func close() {
        isBlocking = true
        moneroAdapter.delegate = nil
        moneroAdapter.close()
        moneroAdapter.clear()
    }
    
    public func startUpdate() {
        guard !isBlocking else {
            return
        }
        
        moneroAdapter.startRefreshAsync()
    }
    
    public func transactions() -> TransactionHistory {
        if let moneroTransactionHistory = self.moneroTransactionHistory {
            return moneroTransactionHistory
        } else {
            let _moneroTransactionHistory = MoneroTransactionHistory(moneroWalletHistoryAdapter: MoneroWalletHistoryAdapter(wallet: moneroAdapter))
            self.moneroTransactionHistory = _moneroTransactionHistory
            return _moneroTransactionHistory
        }
    }
    
    public func subaddresses() -> Subaddresses {
        return Subaddresses(wallet: moneroAdapter)
    }
    
    public func send(amount: Amount?, to address: String, withPriority priority: TransactionPriority) throws -> PendingTransaction {
        do {
            let moneroPendingTransactionAdapter = try self.moneroAdapter.createTransaction(
                toAddress: address,
                withPaymentId: "",
                amountStr: amount?.formatted(),
                priority: priority.rawValue)
            return MoneroPendingTransaction(moneroPendingTransactionAdapter: moneroPendingTransactionAdapter)
        } catch let error as NSError {
            if let transactionError = TransactionError(from: error, amount: amount, balance: self.balance) {
                throw transactionError
            } else {
                throw error
            }
        }
    }
    
    public func send(amount: Amount?, to address: String, paymentID: String = "", withPriority priority: TransactionPriority) throws -> PendingTransaction {
        do {
            let moneroPendingTransactionAdapter = try self.moneroAdapter.createTransaction(
                toAddress: address,
                withPaymentId: paymentID,
                amountStr: amount?.formatted(),
                priority: priority.rawValue)
            return MoneroPendingTransaction(moneroPendingTransactionAdapter: moneroPendingTransactionAdapter)
        } catch let error as NSError {
            if let transactionError = TransactionError(from: error, amount: amount, balance: self.balance) {
                throw transactionError
            } else {
                throw error
            }
        }
    }
    
    public func integratedAddress(for paymentId: String) -> String {
        return self.moneroAdapter.integratedAddress(for: paymentId)
    }
}

// MARK: MoneroWallet + MoneroWalletAdapterDelegate

extension MoneroWallet: MoneroWalletAdapterDelegate {
    public func newBlock(_ block: UInt64) {
        onNewBlock?(block)
    }

    public func updated() {}

    public func refreshed() {
        onSynced?()
        onConnectionStatusChange?(.synced)
    }

    public func moneyReceived(_ txId: String!, amount: UInt64) {
        onBalanceChange?(self)
    }

    public func moneySpent(_ txId: String!, amount: UInt64) {
        onBalanceChange?(self)
    }

    public func unconfirmedMoneyReceived(_ txId: String!, amount: UInt64) {
        onBalanceChange?(self)
    }
}
