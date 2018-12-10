import Foundation

public protocol PendingTransaction {
    var description: PendingTransactionDescription { get }
    //    var id: String { get }
    func commit(_ handler: @escaping (Result<Void>) -> Void)
}
