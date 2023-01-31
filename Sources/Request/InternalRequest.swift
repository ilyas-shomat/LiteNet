//
//  InternalRequest.swift
//
//  Created by Ilyas Shomat on 15.03.2022.
//

import Foundation
import Alamofire

class InternalRequest {
    private let endpoint: Endpoint
    private let session: Session
    private let logger: LiteNetLoggerProtocol
    
    private let emptyResponseCodes: Set<Int> = [200, 201, 204, 205]
        
    public var request: DataRequest {
        let request: URLRequest = endpoint.urlRequest
        let interceptor: RequestInterceptor = LiteNetInterceptor(endpoint: endpoint)
        
        return session.request(request, interceptor: interceptor)
    }
    
    public var uploadRequest: UploadRequest {
        var formDataList: [FormData] = .init()
        
        switch endpoint.task {
        case .uploadFormData(let formData):
            formDataList = formData
        default: ()
        }
        
        return session.upload(
            multipartFormData: { multipart in
                for data in formDataList {
                    multipart.append(data.data, withName: data.name, mimeType: data.mime.value)
                }
            },
            to: endpoint.url
        )
    }
    
    init(session: Session, endpoint: Endpoint, logger: LiteNetLoggerProtocol) {
        self.session = session
        self.endpoint = endpoint
        self.logger = logger
    }
    
    func process<T: Codable, E: Codable>(
        responseJsonType: T.Type,
        errorJsonType: E.Type,
        jsonCompletion: @escaping JsonCodableErrorCompletion<T, E>
    ) {
        switch endpoint.task {
        case .uploadFormData:
            uploadFormData(
                responseJsonType: responseJsonType,
                errorJsonType: errorJsonType,
                jsonCompletion: jsonCompletion
            )
        default:
            uploadJsonType(
                responseJsonType: responseJsonType,
                errorJsonType: errorJsonType,
                jsonCompletion: jsonCompletion
            )
        }
    }
    
    func uploadJsonType<T: Codable, E: Codable>(
        responseJsonType: T.Type,
        errorJsonType: E.Type,
        jsonCompletion: @escaping JsonCodableErrorCompletion<T, E>
    ) {
        _ = request
            .validate()
            .responseData(
                emptyResponseCodes: emptyResponseCodes,
                completionHandler: { response in
                    self.handleJsonResponse(
                        response: response,
                        responseJsonType: responseJsonType,
                        errorJsonType: errorJsonType,
                        jsonCompletion: jsonCompletion
                    )
                }
            )
    }
    
    func uploadFormData<T: Codable, E: Codable>(
        responseJsonType: T.Type,
        errorJsonType: E.Type,
        jsonCompletion: @escaping JsonCodableErrorCompletion<T, E>
    ) {
        _ = uploadRequest
            .validate()
            .responseData(
                emptyResponseCodes: emptyResponseCodes,
                completionHandler: { response in
                    self.handleJsonResponse(
                        response: response,
                        responseJsonType: responseJsonType,
                        errorJsonType: errorJsonType,
                        jsonCompletion: jsonCompletion
                    )
                }
            )
    }
    
    private func handleJsonResponse<T: Codable, E: Codable>(
        response: AFDataResponse<Data>,
        responseJsonType: T.Type,
        errorJsonType: E.Type,
        jsonCompletion: @escaping JsonCodableErrorCompletion<T, E>
    ) {
        switch response.result {
        case .success(let data):
            log(data: response, error: nil)
            
            if data.isEmpty {
                jsonCompletion(.success(nil))
            }
            else {
                do  {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    jsonCompletion(.success(json))
                }
                catch(let error) {
                    log(data: response, error: error)
                    jsonCompletion(.failure(.decoding(message: error.localizedDescription)))
                }
            }
            
        case .failure(let error):
            log(data: response, error: error)

            if let data = response.data, E.self != Empty.self {
                do  {
                    let json = try JSONDecoder().decode(E.self, from: data)
                    jsonCompletion(.associatedFailure(json))
                }
                catch(let error) {
                    log(data: response, error: error)
                    jsonCompletion(.failure(.decoding(message: error.localizedDescription)))
                }
            }
            
            else {
                jsonCompletion(
                    .failure(
                        .serverError(
                            message: error.localizedDescription,
                            statusCode: response.response?.statusCode
                        )
                    )
                )
            }
        }
    }
    
    private func log(data: Any? = nil, error: Error? = nil) {
        logger.log(data: data, error: error)
    }
}
