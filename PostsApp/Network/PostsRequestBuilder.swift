import Alamofire

extension AlamofireRequestBuilder {

    func customSessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = buildHeaders()

        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        sessionManager.adapter = DependencyContainer.resolver.resolve(Alamofire.RequestAdapter.self, name: PostsRequestAdapter.injectionKey)!
        return sessionManager
    }

}

// MARK: - Custom request builders

final class PostsRequestBuilder<T>: AlamofireRequestBuilder<T> {

    override func createSessionManager() -> SessionManager {
        customSessionManager()
    }

    override func makeRequest(manager: SessionManager, method: HTTPMethod, encoding: ParameterEncoding, headers: [String: String]) -> DataRequest {
        HTTPLogger.logRequest(method: method, urlString: URLString, parameters: parameters)
        return manager.request(URLString, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }

    override func dataResponse<T>(response: DataResponse<T>) {
        HTTPLogger.logResponse(response: response)
    }
}

final class PostsDecodableRequestBuilder<T: Decodable>: AlamofireDecodableRequestBuilder<T> {

    override func createSessionManager() -> SessionManager {
        customSessionManager()
    }

    override func makeRequest(manager: SessionManager, method: HTTPMethod, encoding: ParameterEncoding, headers: [String: String]) -> DataRequest {
        HTTPLogger.logRequest(method: method, urlString: URLString, parameters: parameters)
        return manager.request(URLString, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }

    override func dataResponse<T>(response: DataResponse<T>) {
        HTTPLogger.logResponse(response: response)
    }
}

final class PostsRequestBuilderFactory: AlamofireRequestBuilderFactory {

    override func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type {
        PostsRequestBuilder<T>.self
    }

    override func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type {
        PostsDecodableRequestBuilder<T>.self
    }
}

extension RequestBuilder {
    func executeWithErrorHandling(completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        execute { response, error in
            guard error == nil, let response = response else {
                print("Error occured during network communication: \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }

            if T.self is Void.Type {
                completion(.success(() as! T))
            } else if let body = response.body {
                completion(.success(body))
            } else {
                completion(.failure(NetworkError.decodeError))
            }
        }
    }
}

enum NetworkError: Error {
    case decodeError
}
