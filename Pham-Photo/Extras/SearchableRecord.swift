//
//  SearchableRecord.swift
//  Pham-Photo
//
//  Created by Colin Smith on 7/23/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation


protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}
