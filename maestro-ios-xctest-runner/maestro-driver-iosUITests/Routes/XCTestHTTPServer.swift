import FlyingFox
import Foundation

enum Route: String, CaseIterable {
    case runningApp
    case swipe
    case swipeV2
    case inputText
    case touch
    case screenshot
    case isScreenStatic
    case pressKey
    case pressButton
    case eraseText
    case deviceInfo
    case setPermissions
    case viewHierarchy
    case status
    case keyboard
    case terminateApp
    
    func toHTTPRoute() -> HTTPRoute {
        return HTTPRoute(rawValue)
    }
}

struct XCTestHTTPServer {
    func start() async throws {
        let port = ProcessInfo.processInfo.environment["PORT"]?.toUInt16()
        let server = HTTPServer(address: .loopback(port: port ?? 22087), timeout: 100)
        if let url = URL(string: "https://www.flipkart.com/search?q=puma+slippers+men&sid=osp%2Ccil%2Ce1r&as=on&as-show=on") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIApplication.shared.open(url, options: [:], completionHandler: { success in
                    if success {
                        NSLog("✅ URL was successfully opened.")
                    } else {
                        NSLog("❌ Failed to open URL.")
                    }
                })
            }

            NSLog("Scene state: \(UIApplication.shared.applicationState.rawValue)") // 0 = active

        }
        
    }
}
