//
//  AdRequestResult.swift
//  AdSSPOptimazationLogic
//
//  Created by songwonje on 2015. 4. 18..
//  Copyright (c) 2015년 songwonje. All rights reserved.
//

import Foundation

class AdRequestResult: NSObject {

  let user: Int
  var adList: [AdRequestResultAd]?
  
  init(user: Int, adList: [AdRequestResultAd]?) {
  
    self.user = user
    self.adList = adList
  }
}