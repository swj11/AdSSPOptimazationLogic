//
//  AdRequestViewModel.swift
//  AdSSPOptimazationLogic
//
//  Created by songwonje on 2015. 4. 18..
//  Copyright (c) 2015년 songwonje. All rights reserved.
//

import Foundation

class AdRequestViewModel: NSObject {

  let service: AdService
  
  init(service: AdService) {
    
    self.service = service
  }

}
