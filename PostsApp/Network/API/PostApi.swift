import Foundation

protocol PostApiInput {
    func getPosts(completion: @escaping (Result<PageResponseDTO<PostDTO>, Error>) -> Void)
}

final class PostApi: PostApiInput {

    private let environmentProvider: EnvironmentProviderInput
    private let requestBuilderFactory: RequestBuilderFactory

    init(environmentProvider: EnvironmentProviderInput, requestBuilderFactory: RequestBuilderFactory) {
        self.environmentProvider = environmentProvider
        self.requestBuilderFactory = requestBuilderFactory
    }

    func getPosts(completion: @escaping (Result<PageResponseDTO<PostDTO>, Error>) -> Void) {
        getPostsWithRequestBuilder().executeWithErrorHandling(completion: completion)
    }

}

extension PostApi {

    private func getPostsWithRequestBuilder() -> RequestBuilder<PageResponseDTO<PostDTO>> {
        let path = "/post"
        let URLString = environmentProvider.baseUrl + path
        let url = URLComponents(string: URLString)
        let requestBuilder: RequestBuilder<PageResponseDTO<PostDTO>>.Type = requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: nil, isBody: false)
    }

}
