//
//  CalenderResponseString.swift
//  INTERNZ
//
//  Created by 최은지 on 01/01/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

struct calenderResponseString: Codable {
    let status: Int
    let success: Bool
    let message: String
    
    let data: [calenderListDataClass]
    
    struct calenderListDataClass: Codable{
        let logo: String
        let jobIdx: Int
        let calenderIdx: Int
        let company: String
        let team: String
        let d_day: Int
        let end_date: String
    }
}

