import XCTest
import FlyingFox
import Foundation

@MainActor
struct OpenURLHandler: HTTPHandler {
    func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse {
        guard let requestBody = try? await JSONDecoder().decode(OpenURLRequest.self, from: request.bodyData) else {
            return AppError(type: .precondition, message: "Invalid request body for open URL").httpResponse
        }

        let urlString = requestBody.url
        guard let url = URL(string: urlString) else {
            return AppError(type: .precondition, message: "Malformed URL string: \(urlString)").httpResponse
        }

        let app = XCUIApplication()
        app.activate()

        // Use Siri or deep link invocation workaround
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        safari.activate()
        safari.buttons["URL"].tap()
        safari.typeText(url.absoluteString)
        safari.buttons["Go"].tap()

        return HTTPResponse(statusCode: .ok)
    }
}
