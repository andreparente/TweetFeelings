import Reachability
import NotificationCenter

typealias ConnectionHandler = ((_ hasConnection: Bool) -> Void)

class ReachabilityManager {
    private let reachability = try? Reachability()
    var connectionHandler: ConnectionHandler?
    
    init() {
        start()
    }
    
    func set(connectionHandler: ConnectionHandler?) {
        self.connectionHandler = connectionHandler
    }
    
    func start() {
        do {
            try reachability?.startNotifier()
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(reachabilityChanged(note:)),
                                                   name: NSNotification.Name.didReachabilityChange,
                                                   object: reachability)
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    public func stop() {
            reachability?.stopNotifier()
            NotificationCenter.default.removeObserver(self,
                                                      name: NSNotification.Name.didReachabilityChange,
                                                      object: reachability)
    }
    
    @objc
    private func reachabilityChanged(note: Notification) {
        if
            let reachability = note.object as? Reachability,
            let connectionHandler = connectionHandler {
            connectionHandler(reachability.connection != .unavailable)
        }
    }
}
