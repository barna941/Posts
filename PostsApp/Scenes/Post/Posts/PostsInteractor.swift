protocol PostsInteractorInput: AnyObject {
    func getPosts(completion: @escaping (Result<[PostsModel.Post], Error>) -> Void)
}

final class PostsInteractor: PostsInteractorInput {

    private let postApi: PostApiInput

    init(postApi: PostApiInput) {
        self.postApi = postApi
    }

    func getPosts(completion: @escaping (Result<[PostsModel.Post], Error>) -> Void) {
        postApi.getPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(page):
                completion(.success(self.map(page: page)))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func map(page: PageResponseDTO<PostDTO>) -> [PostsModel.Post] {
        page.data.map { post in
            PostsModel.Post()
        }
    }

}
