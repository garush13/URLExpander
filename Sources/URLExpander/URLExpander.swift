//
//  URLExpander.swift
//  URLExpander
//
//  Created by Garush Batikyan on 13.07.22.
//  Copyright © 2022 Garush Batikyan. All rights reserved.
//

import Foundation

public class URLExpander: NSObject, URLSessionTaskDelegate, URLSessionDelegate {
    public static let shared = URLExpander()
    
    lazy var session: URLSession = {
        let session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: nil
        )
        return session
    }()
    
    
    @available(macOS 12.0, *)
    public func expand(url: URL) async -> URL? {
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        
        let response = try? await session.data(for: request, delegate: self)
        
        let headers = (response?.1 as? HTTPURLResponse)?.allHeaderFields
        
        if let location = headers?["Location"] as? String {
            return URL(string: location)
        }
        
        return nil
    }
    
    @available(macOS 12.0, *)
    public func expand(url: String) async -> URL? {
        if let url = URL(string: url) {
            return await expand(url: url)
        }
        return nil
    }
    
    public func expand(url: URL, completion: @escaping (URL?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        let task = session.dataTask(with: request) { _, response, error in
            if error == nil,
                let response = response {
                let headers = (response as? HTTPURLResponse)?.allHeaderFields
                if let location = headers?["Location"] as? String {
                    let expandedURL = URL(string: location)
                    completion(expandedURL)
                    return
                }
            }
            completion(nil)
        }
        task.resume()
    }
    
    public func expand(url: String, completion: @escaping (URL?) -> Void) {
        if let url = URL(string: url) {
            expand(url: url, completion: completion)
            return
        }
        completion(nil)
    }
    
    public func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest,
        completionHandler: @escaping (URLRequest?) -> Void
    ) {
        completionHandler(nil)
    }
}
