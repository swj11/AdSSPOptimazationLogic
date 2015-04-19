//
//  Service.swift
//  AdSSPOptimazationLogic
//
//  Created by songwonje on 2015. 4. 18..
//  Copyright (c) 2015년 songwonje. All rights reserved.
//

import Foundation

protocol AdService {

  func adRequest(parameterDict: [String : String]) -> RACSignal
  
  func selectAd(parameterDict: [String : String], user: Int) -> RACSignal
  
}