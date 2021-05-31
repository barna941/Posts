import Alamofire

final class HTTPLogger {

    static func logRequest(method: HTTPMethod, urlString: String, parameters: Parameters?) {
        var message = "\n-> \(method.rawValue) REQUEST to " + urlString + "\n"
        message.append("BODY:")
        if let bodyData = parameters?["jsonData"] as? Data {
            message.append("\n  \(String(data: bodyData, encoding: String.Encoding.utf8) ?? "")")
        } else {
            message.append(" empty")
        }

        print(message)
    }

    static func logResponse<T>(response: DataResponse<T>) {
        var message = "\n<- \(response.request?.httpMethod ?? "") RESPONSE from " + (response.request?.url?.absoluteString ?? "") + "\n"
        message.append("STATUS CODE: \(response.response?.statusCode != nil ? String(response.response!.statusCode) : "")\n")
        message.append("BODY:\n")

        defer {
            print(message)
        }

        switch T.self {
        case is Void.Type:
            message.append("Void response, body is empty")

        default:
            guard let data = response.data else {
                message.append("Data response is expected, but body is empty")
                break
            }
            let body = String(data: data, encoding: .utf8)

            message.append("\(body ?? "Empty")")
        }
    }

    static func logRequest(request: Request) {
        var message = "\n<- \(request.request?.httpMethod ?? "") RESPONSE from " + (request.request?.url?.absoluteString ?? "") + "\n"
        message.append("STATUS CODE: \(request.response?.statusCode != nil ? String(request.response!.statusCode) : "")\n")
        print(message)
    }

}
