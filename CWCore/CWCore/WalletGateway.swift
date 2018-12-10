import Foundation

public protocol WalletGateway {
    static var path: String { get }
    static var type: WalletType { get }
    
    static func fetchWalletsList() -> [WalletIndex]
  
    init()
    func create(withName name: String, andPassword password: String) throws -> Wallet
    func load(withName name: String, andPassword password: String) throws -> Wallet
    func recoveryWallet(withName name: String, andSeed seed: String, password: String, restoreHeight: UInt64) throws -> Wallet
    func recoveryWallet(withName name: String, publicKey: String, viewKey: String, spendKey: String, password: String, restoreHeight: UInt64) throws -> Wallet
    func remove(withName name: String) throws
    func isExist(withName name: String) -> Bool
}
