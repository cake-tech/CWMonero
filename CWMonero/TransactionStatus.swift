import Foundation

public enum TransactionStatus: Equatable {
    case ok
    case pending
    case error(String)
}
