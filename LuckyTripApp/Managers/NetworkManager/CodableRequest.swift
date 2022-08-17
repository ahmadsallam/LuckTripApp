//
//  File.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation
import Alamofire

protocol NetworkingProtocol: AnyObject {}

protocol CodableRequestProtocol: NetworkingProtocol {
    typealias codableRequestCompletionHandler<T: Codable> = (
        _ result: Result<T>
    ) -> Void

    func request<T: Codable>(
        request: BaseRequest,
        responseCompletition: @escaping codableRequestCompletionHandler<T>)

}

extension Networking: CodableRequestProtocol {

    final func request<T: Codable>(
        request: BaseRequest,
        responseCompletition: @escaping codableRequestCompletionHandler<T>
    ) {

        let method = HTTPMethod(rawValue: request.methods.rawValue)
        var host: String = ""
        
        host = String.init(format: "%@%@",
                           Configuration.shared.apiURL,
                           request.path)


        guard let url: URLConvertible = URL(
                string: host
        ) else { return }


        let request = self.session?.request(url,
                                            method: method,
                                            parameters: [:],
                                            encoding: URLEncoding.default,
                                            headers: [:]).cURLDescription { description in
            print(description)
        }
        
        debugPrint(request ?? "")

        request?.response(completionHandler: { [weak self] (dataResponse) in

            guard let _ = self else { return }

            do {
                let model = try Decoder<T>.decode(data: dataResponse.data)

                responseCompletition(.success(model))

            } catch let someError {
                if let err = someError as? NetworkError {
                    responseCompletition(.failure(err))
                }
            }
        })
    }


}
