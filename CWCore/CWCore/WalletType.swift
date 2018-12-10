import Foundation

public enum WalletType: Int {
    case monero, bitcoin
    
    public init?(from string: String) {
        let str = string.lowercased()
        
        switch str {
        case WalletType.bitcoin.string().lowercased():
            self = .bitcoin
        case WalletType.monero.string().lowercased():
            self = .monero
        default:
            return nil
        }
    }
    
    public var currency: CryptoCurrency {
        switch self {
        case .monero:
            return .monero
        case .bitcoin:
            return .bitcoin
        }
    }
    
    public func string() -> String {
        switch self {
        case .bitcoin:
            return "Bitcoin"
        case .monero:
            return "Monero"
        }
    }
}
