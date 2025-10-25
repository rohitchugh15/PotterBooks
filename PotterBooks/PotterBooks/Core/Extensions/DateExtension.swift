//
//  DateExtension.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 26/10/25.
//

import Foundation

extension Date {
    
    func toString(formatter style: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = style
        return dateFormatter.string(from: self)
    }
}
