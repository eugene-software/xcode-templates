//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file is generated by custom SKELETON Xcode template.
//

import Foundation

class CustomJSONDecoder: JSONDecoder {
    
    enum DateError: String, Error {
        case invalidDate
    }
    
    override init() {
        super.init()
        
        keyDecodingStrategy = .convertFromSnakeCase
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        dateDecodingStrategy = .custom({ (decoder) -> Date in
            
            let container = try decoder.singleValueContainer()
            
            if let dateStr = try? container.decode(String.self) {
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
                if let date = formatter.date(from: dateStr) {
                    return date
                }
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                if let date = formatter.date(from: dateStr) {
                    return date
                }
                formatter.dateFormat = "MM dd, yyyy"
                if let date = formatter.date(from: dateStr) {
                    return date
                }
                formatter.dateFormat = "yyyy-MM-dd"
                if let date = formatter.date(from: dateStr) {
                    return date
                }
            } else if let timestamp = try? container.decode(TimeInterval.self) {
                return Date(timeIntervalSince1970: timestamp / 1000)
            }
            
            throw DateError.invalidDate
        })
    }
}


class CustomJSONEncoder: JSONEncoder {
    
    override init() {
        super.init()
        
        dateEncodingStrategy = .iso8601
        keyEncodingStrategy = .convertToSnakeCase
    }
}