//
//  ViewModelServicesImpl.swift
//  AdSSPOptimazationLogic
//
//  Created by songwonje on 2015. 4. 18..
//  Copyright (c) 2015년 songwonje. All rights reserved.
//

import Foundation

class ViewModelServicesImpl: ViewModelServices {

  let adService: AdService
  
  init() {
    self.adService = AdServiceImpl()
    
  }
  
  
  
}
