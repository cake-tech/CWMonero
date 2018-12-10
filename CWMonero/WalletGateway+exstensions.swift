import Foundation
import CWCore

public enum FileManagerError: Error {
    case cannotFindWalletDir
}

extension FileManager {
    var walletDirectory: URL? {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func createWalletDirectory(for name: String) throws -> URL {
        guard var url  = walletDirectory else {
            throw FileManagerError.cannotFindWalletDir
        }
        
        url.appendPathComponent(name, isDirectory: true)
        
        var isDir: ObjCBool = true
        
        if !fileExists(atPath: url.path, isDirectory: &isDir) && isDir.boolValue {
            try createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
        }
        
        return url
    }
    
    func walletDirectory(for name: String) throws -> URL {
        guard var url  = walletDirectory else {
            throw FileManagerError.cannotFindWalletDir
        }
        
        url.appendPathComponent(name, isDirectory: true)
        
        var isDir: ObjCBool = true
        
        guard fileExists(atPath: url.path, isDirectory: &isDir) && isDir.boolValue  else {
            throw FileManagerError.cannotFindWalletDir
        }
        
        return url
    }
}


extension WalletGateway {
    public func makeConfigURL(for walletName: String) -> URL {
        let folderURL = makeDirURL(for: walletName)
        let filename = walletName + ".json"
        return folderURL.appendingPathComponent(filename)
    }
    
    public func makeURL(for walletName: String) -> URL {
        let folderURL = makeDirURL(for: walletName)
        return folderURL.appendingPathComponent(walletName)
    }
    
    public func makeDirURL(for walletName: String) -> URL {
        guard var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return URL(fileURLWithPath: Self.path + "/" + walletName)
        }
        if !Self.path.isEmpty {
            url.appendPathComponent(Self.path)
        }
        url.appendPathComponent(walletName)
        var isDir: ObjCBool = true
        
        if !FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir) || !isDir.boolValue {
            return try! FileManager.default.createWalletDirectory(for: walletName)
        }
        
        return url
    }
}
