//
//  BundleExtension.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation

extension Bundle {
    
    func dataFromJson(fileName: String) -> Data? {
        guard let url = self.url(forResource: fileName, withExtension: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
}
