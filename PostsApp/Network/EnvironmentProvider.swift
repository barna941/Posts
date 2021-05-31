import Foundation

protocol EnvironmentProviderInput {
    var baseUrl: String { get }
}

final class EnvironmentProvider: EnvironmentProviderInput {
    var baseUrl: String {
        "https://dummyapi.io/data/api"
    }
}
