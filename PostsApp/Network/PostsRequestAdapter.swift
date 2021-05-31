import Alamofire

final class PostsRequestAdapter: Alamofire.RequestAdapter {

    static var injectionKey: String { String(describing: self) }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("60ae1b4f1d13db59ecf4aef3", forHTTPHeaderField: "app-id")
        return urlRequest
    }

}
