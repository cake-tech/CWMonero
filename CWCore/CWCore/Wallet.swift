import Foundation

public protocol Wallet {
    static var walletType: WalletType { get }
    var name: String { get }
    var balance: Amount { get }
    var unlockedBalance: Amount { get }
    var address: String { get }
    var currentHeight: UInt64 { get }
    var seed: String { get }
    var isConnected: Bool { get }
    var isWatchOnly: Bool { get }
    var keys: WalletKeys { get }

    var onNewBlock: ((UInt64) -> Void)? { get set }
    var onBalanceChange: ((Wallet) -> Void)? { get set }
    var onSynced: (() -> Void)? { get set }
    var onConnectionStatusChange: ((ConnectionStatus) -> Void)? { get set }
//    func send(amount: Amount?, to address: String, withPriority priority: TransactionPriority) throws -> PendingTransaction
    func blockchainHeight() throws -> UInt64
    func changePassword(newPassword: String) throws
    func save() throws
    func connect(to uri: String, login: String, password: String) throws
    func close()
    func startUpdate()
}

extension Wallet {
  public var type: WalletType {
    return Self.walletType
  }
}
