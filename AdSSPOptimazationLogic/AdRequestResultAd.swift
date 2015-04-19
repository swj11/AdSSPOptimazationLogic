//
//  AdRequestResultAd.swift
//  AdSSPOptimazationLogic
//
//  Created by songwonje on 2015. 4. 18..
//  Copyright (c) 2015년 songwonje. All rights reserved.
//

import Foundation

class AdRequestResultAd: NSObject {
  
  let bid: Int
  let name: String
  
  init(bid: Int, name: String) {
  
    self.bid = bid
    self.name = name
  }
}
