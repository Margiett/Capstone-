//
//  Date+Extensions.swift
//  Capstone
//
//  Created by Margiett Gil on 6/2/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation

extension Date {
    public func dateString(_ format: String = "EEEE, MMM d, h:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        //self represents the date object itself
        //dateValue().dateString()
        return dateFormatter.string(from: self)
        
    }
}
