import Foundation

@Observable
class TelemetryManager {
    static let shared = TelemetryManager()
    
    var hasConsent: Bool {
        get { UserDefaults.standard.bool(forKey: "telemetry_consent") }
        set { UserDefaults.standard.set(newValue, forKey: "telemetry_consent") }
    }
    
    func logEvent(name: String, parameters: [String: Any]) {
        guard hasConsent else { return }
        print("Telemetry Logged: \(name) with \(parameters)")
        // In the next phase, this will call FirebaseAnalytics.logEvent
    }
}