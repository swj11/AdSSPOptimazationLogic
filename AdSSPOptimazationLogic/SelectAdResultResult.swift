//
//  SelectAdResultResult.swift
//  AdSSPOptimazationLogic
//
//  Created by songwonje on 2015. 4. 18..
//  Copyright (c) 2015년 songwonje. All rights reserved.
//

import Foundation

class SelectAdResultResult: NSObject {
  
  let user: Int
  let seq: Int
  let cpc: Int
  let isClick: Bool
  let name: String
  
  init(user: Int, seq: Int, cpc: Int, isClick: Bool, name: String) {
    
    self.user = user
    self.seq = seq
    self.cpc = cpc
    self.isClick = isClick
    self.name = name
  }
  
}
