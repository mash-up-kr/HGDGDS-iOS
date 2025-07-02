//
//  HGNetworkLogger.swift
//  HGNetwork
//
//  Created by Enes on 7/2/25.
//

import Alamofire

import HGLogger

struct HGNetworkLogger: EventMonitor {
    func requestDidFinish(_ request: Request) {
        #if DEBUG
        LoggerUtil.log(
        """
        \n🌐🌐🌐🌐 Request 🌐🌐🌐🌐
        URL: \(request.request?.url?.absoluteString ?? "nil")
        Method: \(request.request?.httpMethod ?? "nil")
        Header: \(request.request?.allHTTPHeaderFields ?? [:])
        Body: \(request.request?.httpBody?.toPrettyPrintedString ?? "nil")
        """
        )
        #endif
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        #if DEBUG
        LoggerUtil.log(
        """
        \n✅✅✅✅ Response Value ✅✅✅✅
        status code: \(response.response?.statusCode ?? -1)
        Data: \(response.data?.toPrettyPrintedString ?? "nil")
        """
        )
        #endif
    }
    
    func request(_ request: Request, didFailToCreateURLRequestWithError error: AFError) {
        LoggerUtil.log(error, level: .error)
    }
}
