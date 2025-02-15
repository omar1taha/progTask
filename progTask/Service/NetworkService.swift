//
//  NetworkService.swift
//  progTask
//
//  Created by Apple on 6/6/20.
//  Copyright © 2020 taj. All rights reserved.
//

import Foundation
import Moya
import Result

enum tajService {
    case test(url: String)

}

/// Network activity change notification type.
public enum NetworkActivityChangeType {
    case began, ended
}

/// Notify a request's network activity changes (request begins or ends).
public final class NetworkActivityPlugin: PluginType {
    
    public typealias NetworkActivityClosure = (_ change: NetworkActivityChangeType, _ target: TargetType) -> Void
    let networkActivityClosure: NetworkActivityClosure
    
    /// Initializes a NetworkActivityPlugin.
    public init(networkActivityClosure: @escaping NetworkActivityClosure) {
        self.networkActivityClosure = networkActivityClosure
    }
    
    // MARK: Plugin
    /// Called by the provider as soon as the request is about to start
    public func willSend(_ request: RequestType, target: TargetType) {
        networkActivityClosure(.began, target)
    }
    
    /// Called by the provider as soon as a response arrives, even if the request is canceled.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        networkActivityClosure(.ended, target)
    }
}


extension tajService: TargetType{
    

    
    
        var baseURL: URL{
            switch self {
                case .test( let url):
                    return URL(string: url) ?? URL(string: "")!
            }
        }
        
        var path: String{
            switch self {
                case .test:
                    return ""
          

            }
            
        }
    
        var method: Moya.Method {
            switch self {
                case .test:
                    return .post
            }
        }
    
        var sampleData: Data {
            return "{'id': 'nil'}".data(using: .utf8)!
            
        }
    
    
        var task: Task{
            return .requestPlain
        }
    
        var headers: [String : String]?{
            return nil
        }
    
        

}
