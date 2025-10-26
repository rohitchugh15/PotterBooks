//
//  EncodableExtension.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 26/10/25.
//

import Foundation

extension Encodable {
    
    func getURLQuery(dateFormat:String? = nil) -> String {
        let requestDictionary = self.toJSON(dateFormat: dateFormat).flatMap{$0 as? [String: Any?]}
        
        if requestDictionary?.isEmpty == false {
            var queryItems: [URLQueryItem] = []
            
            requestDictionary?.forEach({ (key, value) in
                if(value != nil){
                    let strValue = value.map { String(describing: $0) }
                    if(strValue != nil && strValue?.count != 0){
                        queryItems.append(URLQueryItem(name: key, value: strValue))
                    }
                }
            })
            
            var components = URLComponents()
            components.queryItems = queryItems
            
            return components.percentEncodedQuery ?? ""
        }
        
        debugPrint("getURLQueryItems => Error => Conversion failed")
        
        return ""
    }
    
    func toJSON(dateFormat:String? = nil) -> [String:Any]? {
        let encoder = JSONEncoder()
        if dateFormat != nil {
            encoder.dateEncodingStrategy = self.encodeDate(with: dateFormat ?? "dd-MM-yyyy")
        }
        do {
            let jsonData = try encoder.encode(self)
            return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String : Any]
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func encodeDate(with dateformat:String) -> JSONEncoder.DateEncodingStrategy {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = dateformat
        return .formatted(dateFormater)
    }
}
