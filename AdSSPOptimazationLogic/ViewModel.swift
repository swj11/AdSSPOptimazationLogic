//
//  ViewModel.swift
//  AdSSPOptimazationLogic
//
//  Created by songwonje on 2015. 4. 18..
//  Copyright (c) 2015년 songwonje. All rights reserved.
//

import Foundation

class ViewModel: NSObject {
  
  //MARK: Properties
  var adRequestCommand: RACCommand!
  var selectAdCommand: RACCommand!
  
  private let services: ViewModelServices
  
  dynamic var round = 3
  
  dynamic var seq = 1
  private let maxCount = 5000
  dynamic var totalCPC = 0
  dynamic var totalClick = 0
  dynamic var totalNoClick = 0
  
//  private var selectAdResult = [AnyObject]()
  
  private var selectAdResult = NSMutableArray()
  
  private var user = 0
  
  init(services: ViewModelServices) {
    
    self.services = services
    
    
    super.init()
    
    
    
    adRequestCommand = RACCommand() {
      (any: AnyObject!) -> RACSignal in
      
      return self.adRequestCommandSignal(["round": "\(self.round)", "seq": "\(self.seq)"]).logAll()
      
//      return self.adRequestCommandSignal(any as! [String: String]).logAll()
      
    }
    
    selectAdCommand = RACCommand() {
      (any: AnyObject!) -> RACSignal in
      
      
      return self.selectAdCommandSignal(any as! [String: String]).logAll()
    }
    
    
  }
  
  
  private func checkAlreadyClickedAdByUser(user: Int, adList: [AdRequestResultAd]) {
  
    self.selectAdResult.rac_sequence.filter { (any: AnyObject!) -> Bool in
      
      let result = any as! SelectAdResultResult
      
//      return result.user == user && contains(adList, result.name)
      
      return result.user == user
      }
  }
  
  //MARK: Private
  private func adRequestCommandSignal(parameterDict: [String: String]) -> RACSignal {
    
    return services.adService.adRequest(parameterDict).doNextAs(
      { (results: AdRequestResult) -> () in
      
        println("private func adRequestCommandSignal(parameterDict) -> RACSignal {")
        
        results.adList?.sort({ $0.bid > $1.bid })
        
        println("first : \(results.adList?.first?.name), \(results.adList?.first?.bid)")
        
        if results.adList != nil {
          
          
          // check 기존에 해당 user가 click한 광고 중 가장 cpc가 높은 광고
          
          // check 기존에 click이 발생한 광고 중 cpc가 높은 광고
          
          
          
          if let firstAd = results.adList?.first {
            
            //  "http://igaw-hack.elasticbeanstalk.com/ssp/Exam/SelectAD?round={0}&seq={1}&service_key={2}&ad={3}", round, seq, service_key, ad
            
            self.user = results.user
            
            self.selectAdCommand.execute(["round": "\(self.round)", "seq": "\(self.seq)", "ad": firstAd.name, "service_key" : "ff956ff7-3bcf-4793-955f-2142a86d34de"])
          }
        }
    })
  }
  
  private func selectAdCommandSignal(parameterDict: [String: String]) -> RACSignal {
    
    return services.adService.selectAd(parameterDict, user: self.user).doNextAs(
      { (result: SelectAdResult) -> () in
        
        println("private func selectAdCommandSignal(parameterDict: [String: String]) -> RACSignal { \(result.status)")
        
       
        if result.status == 200 && result.result != nil {
          if result.result?.isClick == true {
            
//            self.selectAdResult.append(result.result!)
            
            self.selectAdResult.addObject(result.result!)
            
            self.totalCPC += result.result!.cpc
            self.totalClick++
          } else {
            self.totalNoClick++
          }
        }
        
        
        self.seq++
        
        if self.seq <= self.maxCount {
        
//          self.adRequestCommandSignal(["round": "\(self.round)", "seq": "\(self.count)"])
          
          self.adRequestCommand.execute(nil)
        
        } else {
        
          // complete & next round
          self.round++
          
          self.printResult()
          
        
        }
    })
  }
  
  private func printResult() {
    
    for result in self.selectAdResult {
      
      let selectAdResultResult = result as! SelectAdResultResult
    
      println("user : \(selectAdResultResult.user), seq : \(selectAdResultResult.seq), cpc : \(selectAdResultResult.cpc), isClick : \(selectAdResultResult.isClick), , name : \(selectAdResultResult.name)")
    }
    
    let numberFormatter = NSNumberFormatter()
    numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
    
    println("---------------------------------------------------------------------------------------------------")
    println("round : \(round) seq: \(numberFormatter.stringFromNumber(seq)!), total cpc: \(numberFormatter.stringFromNumber(self.totalCPC)!), total click : \(numberFormatter.stringFromNumber(self.totalClick)!), , total no click : \(numberFormatter.stringFromNumber(self.totalNoClick)!)")
    
  }
  
  
}
