import Foundation

public protocol Formatted {
    func formatted() -> String
}

public protocol Currency: Formatted {}

public protocol Amount: Formatted {
    var currency: Currency { get }
    var value: UInt64 { get }
}

extension Amount {
    public func compare(with amount: Amount) -> Bool {
        return type(of: amount) == type(of: self) && amount.value == self.value
    }
}

public enum CryptoCurrency: Currency {
    public static var all: [CryptoCurrency] {
        return [.monero, .bitcoin, .ethereum, .liteCoin, .bitcoinCash, .dash]
    }
    
    case monero, bitcoin, ethereum, dash, liteCoin, bitcoinCash
    
    public init?(from string: String) {
        switch string.uppercased() {
        case "XMR":
            self = .monero
        case "BTC":
            self = .bitcoin
        case "ETH":
            self = .ethereum
        case "DASH":
            self = .dash
        case "LTC":
            self = .liteCoin
        case "BCH":
            self = .bitcoinCash
        default:
            return nil
        }
    }
    
    public func formatted() -> String {
        switch self {
        case .monero:
            return "XMR"
        case .bitcoin:
            return "BTC"
        case .ethereum:
            return "ETH"
        case .dash:
            return "DASH"
        case .liteCoin:
            return "LTC"
        case .bitcoinCash:
            return "BCH"
        }
    }
}
