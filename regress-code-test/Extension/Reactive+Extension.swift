//
//  Reactive+Extension.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import Alamofire
import RxSwift
import Photos

extension Request: ReactiveCompatible{}
extension SessionManager: ReactiveCompatible{}

extension Reactive where Base: DataRequest {
    func response<T: Codable>() -> Observable<T> {
        return Observable.create { observer in
            let request = self.base.responseJSON { response in
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // ALAMOFIRE ERROR
                // REQUEST ERROR
                if let error = response.result.error {
                    if error._code == NSURLErrorTimedOut {
                        let error = ErrorModel(HTTPStatusCode.timeout.rawValue, title: "error_time_out_title".localized, message: "error_time_out".localized)
                        observer.onError(error)
//                        SentrySDK.capture(error: error)
                    } else if error._code == NSURLErrorNotConnectedToInternet {
                        let error = ErrorModel(HTTPStatusCode.noInternet.rawValue, title: "error_not_connected_to_internet_title".localized, message: "error_not_connected_to_internet".localized)
                        observer.onError(error)
//                        SentrySDK.capture(error: error)
                    }
                    
                    // NO REQUEST ERROR / NO ALAMOFIRE ERROR / SUCCESS REQUEST
                } else {
                    if let statusCode = response.response?.statusCode {
                        guard (200 ... 206) ~= statusCode else {
                            
                            if statusCode == HTTPStatusCode.unauthorized.rawValue {
//                                if !User.shared.isLogin() {
//                                    return
//                                }
//                                User.shared.logout(apiLogout: false)
//                                let controller = TopViewController.instantiateStoryboard()
//                                controller.modalTransitionStyle =     .coverVertical
//                                controller.modalPresentationStyle = .fullScreen
//                                AppDelegate.shared.window?.rootViewController = controller
//                                return
                            }
                            
                            guard let data = response.data else { return }
                            do {
                                let results: BaseErrorModel = try decoder.decode(BaseErrorModel.self, from: data)
                                let error = ErrorModel(statusCode, title: results.error?.localized ?? "", message: "")
                                observer.onError(error)

                            } catch let error {
                                print(error)
                            }
                            
                            return
                        }
                        
                        guard let data = response.data else { return }
                        do {
                            // decode base on generic Model type
                            let result: T = try decoder.decode(T.self, from: data)
                            observer.onNext(result)
                            observer.onCompleted()
                        } catch (let errors) {
                            do {
                                let results: BaseErrorModel = try decoder.decode(BaseErrorModel.self, from: data)
                                let error = ErrorModel(statusCode, title: results.error?.localized ?? "", message: "")
                                observer.onError(error)
                            } catch {
                                let error = ErrorModel(errors._code, title: "terjadi_kesalahan_title".localized, message: "terjadi_kesalahan".localized)
                                observer.onError(error)
//                                SentrySDK.capture(error: errors)
                            }
                        }
                        observer.onCompleted()
                    } else {
                        let error = ErrorModel(HTTPStatusCode.parsingError.rawValue, title: "error_parsing_title".localized, message: "error_parsing".localized)
                        observer.onError(error)
//                        SentrySDK.capture(error: response.error!)
                    }
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

extension Reactive where Base: SessionManager {
    func encodeMultipartUpload<T: Codable>(to url: URLConvertible, method: HTTPMethod = .post, headers: HTTPHeaders = [:], data: @escaping (MultipartFormData) -> Void) -> Observable<T> {
        return Observable.create { observer in
            self.base.upload(multipartFormData: data,
                             to: url,
                             method: method,
                             headers: headers,
                             encodingCompletion: { (result: SessionManager.MultipartFormDataEncodingResult) in
                                switch result {
                                case .failure(let error):
                                    observer.onError(error)
                                case .success(let request, _, _):
                                    request.responseJSON { response in
                                        
                                     // ALAMOFIRE ERROR
                                        // REQUEST ERROR
                                        if let error = response.result.error {
                                            if error._code == NSURLErrorTimedOut {
                                                let error = ErrorModel(HTTPStatusCode.timeout.rawValue, title: "error_time_out_title".localized, message: "error_time_out".localized)
                                                observer.onError(error)
//                                                SentrySDK.capture(error: error)
                                            } else if error._code == NSURLErrorNotConnectedToInternet {
                                                let error = ErrorModel(HTTPStatusCode.noInternet.rawValue, title: "error_not_connected_to_internet_title".localized, message: "error_not_connected_to_internet".localized)
                                                observer.onError(error)
//                                                SentrySDK.capture(error: error)
                                            } else if error._code == NSURLErrorNetworkConnectionLost {
                                                let error = ErrorModel(HTTPStatusCode.timeout.rawValue, title: "error_internet_lost_title".localized, message: "error_internet_lost".localized)
                                                observer.onError(error)
//                                                SentrySDK.capture(error: error)
                                                
                                            }
                                            
                                            // NO REQUEST ERROR / NO ALAMOFIRE ERROR / SUCCESS REQUEST
                                        } else {
                                            guard let data = response.data else { return }
                                            let decoder = JSONDecoder()
                                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                                            do {
                                                // decode base on generic Model type
                                                let result: T = try decoder.decode(T.self, from: data)
                                                observer.onNext(result)
                                                observer.onCompleted()
                                            } catch (let errors) {
                                                let error = ErrorModel(HTTPStatusCode.parsingError.rawValue, title: "error_parsing_title".localized, message: "error_parsing".localized)
                                                observer.onError(error)
                                            }
                                            return
                                        }
                                    }
                                }
            })
            
            return Disposables.create()
        }
    }
}

extension Reactive where Base: PHImageManager {

    public func requestImage(for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?) -> Observable<(UIImage, [AnyHashable: Any]?)> {

        return Observable.create({ [weak manager = self.base] (observer) -> Disposable in
            guard let manager = manager else {
                observer.onCompleted()
                return Disposables.create()
            }

            // TODO: 多次调用
            let requestID = manager
                .requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: { (image, info) in
                    if let image = image {
                        observer.onNext((image, info))
                        observer.onCompleted()
                    }
            })

            return Disposables.create {
                manager.cancelImageRequest(requestID)
            }

        })

    }

    public func requestImageData(for asset: PHAsset, options: PHImageRequestOptions?) -> Observable<(Data, String?, UIImage.Orientation, [AnyHashable : Any]?)> {

        return Observable.create({ [weak manager = self.base] (observer) -> Disposable in
            guard let manager = manager else {
                observer.onCompleted()
                return Disposables.create()
            }

            let requestID = manager
                .requestImageData(for: asset, options: options, resultHandler: { (data, string, imageOrientation, info) in
                    if let error = info?[PHImageErrorKey] as? NSError {
                        observer.onError(error)
                    } else if let data = data {
                        observer.onNext((data, string, imageOrientation, info))
                        observer.onCompleted()
                    }
                })

            return Disposables.create {
                manager.cancelImageRequest(requestID)
            }
            
        })

    }
    
}
