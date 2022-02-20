import Foundation

extension NSObject {
    typealias MemoryAddress = Int
    
    func address() -> MemoryAddress {
        unsafeBitCast(self, to: Int.self)
    }
}
