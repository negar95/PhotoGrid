//
//  String.swift
//  Grid
//
//  Created by Negar Moshtaghi on 22/11/1400 AP.
//

import Foundation

extension String {

    func toDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
}
