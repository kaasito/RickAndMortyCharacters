//
//  BaseApiClient.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 11/9/23.
//

import UIKit
import Alamofire
import Combine

class BaseAPIClient {
    // MARK: - Properties
    private var isReachable: Bool = true
    private var sesionManager: Alamofire.Session!
    private var baseURL: URL {
        if let url = URL(string: Environment.shared.baseURL) {
            return url
        } else {
            print("URL INVALID")
            return URL(string: "")!
        }
    }

    init() {
        self.sesionManager = Session(
            serverTrustManager: ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [String : ServerTrustEvaluating]()))
    }
    
    // MARK: - Public method
    func handler(error: Error?) -> BaseError? {
        if !self.isReachable { return BaseError.noInternetConnection }
        return error != nil ? error as? BaseError : BaseError.generic
    }

    func requestPublisher<T: Decodable>(relativePath: String?,
                                        method: HTTPMethod = .get,
                                        parameters: Parameters? = nil,
                                        urlEncoding: ParameterEncoding = JSONEncoding.default,
                                        type: T.Type = T.self,
                                        base: URL? = URL(string: Environment.shared.baseURL),
                                        customHeaders: HTTPHeaders? = nil) -> AnyPublisher<T, BaseError> {
        guard let url = base, let path = relativePath else {
            return Fail(error: BaseError.generic).eraseToAnyPublisher()
        }

        guard let urlAbsolute = url.appendingPathComponent(path).absoluteString.removingPercentEncoding else {
            return Fail(error: BaseError.generic).eraseToAnyPublisher()
        }

        return sesionManager.request(urlAbsolute, method: method, parameters: parameters, encoding: urlEncoding)
            .validate()
#if DEBUG
            .cURLDescription(on: .main, calling: { p in print(p) })
#endif
            .publishDecodable(type: T.self, emptyResponseCodes: [204])
            .tryMap({ response in
                switch response.result {
                case let .success(result):
                    return result
                case .failure(_):
                    throw self.getApiResponse(error: response.data)
                }
            })
            .mapError({ [weak self] error in
                guard let self = self else { return .generic }
                return self.handler(error: error) ?? .generic
            })
            .eraseToAnyPublisher()
    }

    // MARK: - Private Method
    private func getApiResponse(error: Data?) -> BaseError {
        guard let data = error,
              let json = try? JSONDecoder().decode(ApiResponseError.self, from: data)
        else { return .generic }
        return BaseError.APIresponse(json)
    }
}
