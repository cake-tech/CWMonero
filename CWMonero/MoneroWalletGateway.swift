import UIKit
import CWCore

public final class MoneroWalletGateway: WalletGateway {
    public static var path: String {
        return "monero"
    }

    public static var type: WalletType {
        return .monero
    }

    public static func fetchWalletsList() -> [WalletIndex] {
        guard
            let docsUrl = FileManager.default.walletDirectory,
            let walletsDirs = try? FileManager.default.contentsOfDirectory(atPath: docsUrl.path) else {
                return []
        }

        let wallets = walletsDirs.map { name -> String? in
            var isDir = ObjCBool(false)
            let url = docsUrl.appendingPathComponent(name)
            FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir)

            return isDir.boolValue ? name : nil
            }.compactMap({ $0 })

        return wallets.map { name -> WalletIndex? in
            guard name != ".shared-ringdb" else {
                return nil
            }

            return WalletIndex(name: name, type: .monero)
            }.compactMap({ $0 })
    }

    public init() {}

    public func create(withName name: String, andPassword password: String) throws -> Wallet {
        let moneroAdapter = MoneroWalletAdapter()!
        try moneroAdapter.generate(withPath: self.makeURL(for: name).path, andPassword: password)
        try moneroAdapter.save()
        
        return MoneroWallet(moneroAdapter: moneroAdapter)
    }

    public func load(withName name: String, andPassword password: String) throws -> Wallet {
        let moneroAdapter = MoneroWalletAdapter()!
        let path = self.makeURL(for: name).path
        try moneroAdapter.loadWallet(withPath: path, andPassword: password)
        
        return MoneroWallet(moneroAdapter: moneroAdapter)
    }

    public func recoveryWallet(withName name: String, andSeed seed: String, password: String, restoreHeight: UInt64) throws -> Wallet {
        let moneroAdapter = MoneroWalletAdapter()!
        try moneroAdapter.recovery(at: self.makeURL(for: name).path, mnemonic: seed, andPassword: password, restoreHeight: restoreHeight)
        try moneroAdapter.setPassword(password)
        moneroAdapter.setRefreshFromBlockHeight(restoreHeight)
        moneroAdapter.setIsRecovery(true)
        try moneroAdapter.save()

        return MoneroWallet(moneroAdapter: moneroAdapter)
    }

    public func recoveryWallet(withName name: String, publicKey: String, viewKey: String, spendKey: String, password: String, restoreHeight: UInt64) throws -> Wallet {
        let moneroAdapter = MoneroWalletAdapter()!
        try moneroAdapter.recoveryFromKey(at: self.makeURL(for: name).path, withPublicKey: publicKey, andPassowrd: password, andViewKey: viewKey, andSpendKey: spendKey, withRestoreHeight: restoreHeight)
        try moneroAdapter.setPassword(password)
        moneroAdapter.setRefreshFromBlockHeight(restoreHeight)
        moneroAdapter.setIsRecovery(true)
        try moneroAdapter.save()

        return MoneroWallet(moneroAdapter: moneroAdapter)
    }

    public func remove(withName name: String) throws {
        let walletDir = try FileManager.default.walletDirectory(for: name)
        try FileManager.default.removeItem(atPath: walletDir.path)
    }

    public func isExist(withName name: String) -> Bool {
        guard let _ = try? FileManager.default.walletDirectory(for: name) else {
            return false
        }

        return true
    }
}
