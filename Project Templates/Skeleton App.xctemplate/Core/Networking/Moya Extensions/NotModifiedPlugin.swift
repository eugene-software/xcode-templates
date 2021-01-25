//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file is generated by custom SKELETON Xcode template.
//

import Moya

/// Sets the Response's statusCode to `304` if it can be determined by
/// comparing the HTTP Cache Headers of the request in the URLCache
/// to the cache headers of the current response.
///
/// By default, `Last-Modified` and `Etag` headers are used to determine
/// `Not Modified` status.
///
/// NSURLSession will always return a `200` response along with the response
/// data to the application whenever it receives a 304 Not Modified response
/// from the server.
///
/// In some cases, however, the application may want to know whether the
/// content was modified or not (such as when deciding whether to do an expensive
/// import of the data into a database). This plugin will allow the application
/// to know 304 status based on the specified cache header keys.

final class NotModifiedPlugin: PluginType {

    typealias CacheHeaderKey = String
    typealias CacheHeaderValue = String
    typealias CacheDictionary = [CacheHeaderKey: CacheHeaderValue]

    private let urlCache: URLCache
    private let cacheKeys: [CacheHeaderKey]

    /// For each request, holds the cached header values from the URLCache
    /// in order to compare them against the new header values for each response
    private var cachedHeaders: [URLRequest: CacheDictionary] = [:]


    /// Instantiate a new instance of the NotModifiedPlugin
    ///
    /// - Parameters:
    ///   - urlCache: The URLCache to use; default == URLCache.shared
    ///   - cacheKeys: Unique response header keys to use to determine whether the response
    ///                is modified or not; default == ["Last-Modified", "Etag"]
    init(urlCache: URLCache = URLCache.shared, cacheKeys: Set<CacheHeaderKey> = ["Last-Modified", "Etag"]) {
        self.urlCache = urlCache
        self.cacheKeys = Array(cacheKeys)
    }

    // Before sending the request, safe off previously cached header values if they exist
    func willSend(_ request: RequestType, target: TargetType) {
        guard
            let request = request.request,
            let cachedURLResponse = URLCache.shared.cachedResponse(for: request)?.response as? HTTPURLResponse
        else {
            // Nothing to do if the response hasn't been cached yet
            return
        }

        // For each cacheKey, get the assoicated cached header value (or an empty string if none exists)
        let cacheValues = cacheKeys.map({ (cachedURLResponse.allHeaderFields[$0] as? CacheHeaderValue) ?? "" })

        let cacheDictionary = zip(cacheKeys, cacheValues)
            // Exclude pairs where the value is empty
            .filter({ !$1.isEmpty })
            // Convert each cached key/value header pair into a CacheDictionary
            .reduce(CacheDictionary()) { (dict, cached) in
                var dict = dict
                let (cacheKey, cachedValue) = cached
                dict[cacheKey] = cachedValue
                return dict
            }

        // Store the cached headers for this particular request
        self.cachedHeaders[request] = cacheDictionary
    }

    // Modify the result to include response code `304` if the cached cache headers
    // match the response's cache headers
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        switch result {
        case .success(let response):
            guard let request = response.request else {
                // Nothing to modify if we don't have a request
                break
            }

            // For each cachekey we're concerned with, see if the response's headers match the previously
            // cached values
            let cacheKeysMatch = cacheKeys
                .map({ key -> Bool in
                    if let cachedValue = cachedHeaders[request]?[key], !cachedValue.isEmpty,
                       let responseValue = response.response?.allHeaderFields[key] as? String, !responseValue.isEmpty {
                        return cachedValue == responseValue
                    } else {
                        return false
                    }
                })
                .filter({ $0 == false })
                .isEmpty

            if cacheKeysMatch {
                return makeNotModified(response)
            }

        case .failure:
            // Nothing to modify in case of failure
            break
        }

        return result
    }

    private func makeNotModified(_ response: Moya.Response) -> Result<Response, MoyaError> {
        let notModifiedResponse = Moya.Response(
            statusCode: 304,
            data: response.data,
            request: response.request,
            response: response.response
        )
        return .success(notModifiedResponse)
    }

}
