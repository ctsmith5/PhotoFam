//
//  DateExtension.swift
//  Pham-Photo
//
//  Created by Colin Smith on 7/26/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation
extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
