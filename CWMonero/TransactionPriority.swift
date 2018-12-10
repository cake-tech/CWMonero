import Foundation
import CWCore

public enum TransactionPriority: Formatted {
    case slow, `default`, fast, fastest
    
    public var rawValue: UInt64 {
        switch self {
        case .slow:
            return 1
        case .default:
            return 2
        case .fast:
            return 3
        case .fastest:
            return 4
        }
    }
    
    public init?(rawValue: UInt64) {
        switch rawValue {
        case 1:
            self = .slow
        case 2:
            self = .default
        case 3:
            self = .fast
        case 4:
            self = .fastest
        default:
            return nil
        }
    }
    
    public init?(rawValue: Int) {
        if rawValue > 0 && rawValue <= 4 {
            self.init(rawValue: UInt64(rawValue))
        } else {
            return nil
        }
    }
    
    public func formatted() -> String {
        let description: String
        
        switch self {
        case .slow:
            description = "Slow"
        case .default:
            description = "Regular"
        case .fast:
            description = "Fast"
        case .fastest:
            description = "Fastest"
        }
        
        return description
    }
}
