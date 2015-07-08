//
//  Weather.swift
//  Weather
//
//  Created by 李正宁 on 7/7/15.
//  Copyright (c) 2015 Zhengning Li. All rights reserved.
//

import Foundation


struct Weather {
    var temperature: Int?
    var summary: String?
    
    init() {
        self.temperature = 0
        self.summary = ""
    }
}