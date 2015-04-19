//
//  SelectAdResult.swift
//  AdSSPOptimazationLogic
//
//  Created by songwonje on 2015. 4. 18..
//  Copyright (c) 2015년 songwonje. All rights reserved.
//

import Foundation

class SelectAdResult: NSObject {
  
  let status: Int
  let result: SelectAdResultResult?
  
  init(status: Int, result: SelectAdResultResult?) {
    
    self.status = status
    self.result = result
  }

}
