//
//  JobService.swift
//  INTERNZ
//
//  Created by 최은지 on 30/12/2019.
//  Copyright © 2019 최은지. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkResult2<T, Error> {
    case success(T)
    case failure(Error)
}

class JobListService {
    private init() { }
    
    static let sharedJob = JobListService()
    
    func getJobList(completion: @escaping (NetworkResult2<[jobResponseString
        .JobDataClass], Error>) -> Void) {
        
        let url = APIConstants.jobURL
        
        Alamofire.request(url).responseJSON {
            response in
            switch response.result {
            case .success :
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(jobResponseString.self, from: data)
                    
                    if object.status == 200 {
                        print("통신 성공 ~!!!")
                        completion(.success(object.data))
                    } else {
                        completion(.failure(fatalError("서버 통신 오류 ㅡㅡ ")))
                    }
                    
                } catch (let err){
                    print(err.localizedDescription)
                    completion(.failure(err))
                }
                
                
            case .failure :
                print("failure")
            }
        }
        
        
        
    }
    
    
    
    
}


// 공고
//struct JobService {
//    static let sharedJob = JobService()
//
//    func getJobList(completion: @escaping(NetworkResult<Any>) -> Void){
//
//        let url = APIConstants.jobURL
//
//        Alamofire.request(url).responseJSON {
//            response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//
//                do {
//                    let decoder = JSONDecoder()
//                    let object = try decoder.decode(jobResponseString.self, from: data)
//
//                    if object.success == true {
//                        print("데이터 불러오기 성공!!")
//                        completion(.success(object.data))
//                    } else {
//                        print("데이터 불러오기 실패 ㅡㅡ")
////                       completion(.failure(fatalError("서버이상")))
//                    }
//
//                } catch(let err){
//                    print(err.localizedDescription)
//                }
//
//            case .failure(let err) :
//                print("failure")
//            }
//        }
//    } // getJobList()
//
//
//}
//
//
//
//


//import Foundation
//import Alamofire
//
//struct LoginService {
//
//    static let shared = LoginService()
//
//    func login(_ email:String, _ password: String, completion: @escaping(NetworkResult<Any>) -> Void) {
//        let header: HTTPHeaders = [
//            "Content-Type" : "application/json"
//        ]
//
//        let body: Parameters = [
//            "email": email,
//            "password": password
//        ]
//
//        // 서버로 request 전송 - http 비동기 통신 라이브러리 : 함수가 호출된 순차적으로 진행됨
//        Alamofire.request(APIConstants.loginURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
//            .responseData { response in // response 에 결과값 저장 -> print 해보기
//
//                //                print("request", response.request)
//                //                print("response", response.response)
//                //                print("data", response.data)
//                //                print("result", response.result)
//
//                // parameter 위치
//                switch response.result {
//
//                // 통신 성공 - 네트워크 연결
//                case .success:
//                    if let value = response.result.value {
//
//                        if let status = response.response?.statusCode {
//                            switch status {
//                            case 200:
//                                do {
//                                    let decoder = JSONDecoder()
//                                    print("value", value)
//                                    let result = try decoder.decode(loginResponseString.self, from: value)
//
//                                    // ResponseString2에 있는 success로 분기 처리
//                                    switch result.success {
//
//                                    case true: // 진짜 로그인 성공인 경우
//                                        print("success")
//                                        completion(.success(result.data)) // NetworkResult 에서 접근
//                                    case false:
//                                        completion(.requestErr(result.message))
//                                    }
//                                }
//                                catch {
//                                    completion(.pathErr)
//                                    print(error.localizedDescription)
//                                    print(APIConstants.loginURL)
//                                }
//                            case 400:
//                                completion(.pathErr)
//                            case 500:
//                                completion(.serverErr)
//                            default:
//                                break
//                            }// switch
//                        }// iflet
//                    }
//                    break
//
//
//               // 네트워크 통신 실패
//                case .failure(let err):
//                    print(err.localizedDescription)
//                    completion(.networkFail)
//                    break
//
//                }
//        }
//
//    }
//
//}