//
//  ServicesImpl.swift
//  AdSSPOptimazationLogic
//
//  Created by songwonje on 2015. 4. 18..
//  Copyright (c) 2015년 songwonje. All rights reserved.
//

import Foundation
import Alamofire

class AdServiceImpl: AdService {

  func adRequest(parameterDict: [String : String]) -> RACSignal {
    
//    println("parameterDict : \(parameterDict)")
    
    func adRequestDictionary(response: NSDictionary) -> AdRequestResult {
    
//      println("response: \(response)")
      
      let user = response.valueForKey("user")?.integerValue
      
      if let listArray = response.valueForKey("adlist") as? [[String: AnyObject]] {
        
        let adList = listArray.map {
          (adDict) -> AdRequestResultAd in
      
          let bid = adDict["bid"]!.integerValue
          let name = adDict["name"] as? String
          
          return AdRequestResultAd(bid: bid, name: name!)
        }
      
        return AdRequestResult(user: user!, adList: adList)
        
      } else {
      
        return AdRequestResult(user: user!, adList: nil)
      }
      
      
    }
    
    
//    println("parameterDict : \(parameterDict)")
    
//    "http://igaw-hack.elasticbeanstalk.com/ssp/Exam/GetADRequest?round={0}&seq={1}"
    return self.signalFromAPIURL(.GET, url: "http://igaw-hack.elasticbeanstalk.com/ssp/Exam/GetADRequest",
      arguments: parameterDict, transform: adRequestDictionary)
  }
  
//  "http://igaw-hack.elasticbeanstalk.com/ssp/Exam/SelectAD?round={0}&seq={1}&service_key={2}&ad={3}", round, seq, service_key, ad
  
  func selectAd(parameterDict: [String : String], user: Int) -> RACSignal {
    
//    println("parameterDict : \(parameterDict)")
    
    func selectAdDictionary(response: NSDictionary) -> SelectAdResult {
      
//      println("response: \(response)")
      
      let status = response.valueForKey("status")?.integerValue
      
      var cpc = 0
      var isClick = false
      var name = ""
      if let result = response.valueForKey("result") as? [String: AnyObject] {
        
        cpc = result["cpc"]!.integerValue
        isClick = result["isClick"]!.boolValue
        name = result["name"] as! String
        
      }
      

      return SelectAdResult(status: status!, result: SelectAdResultResult(user: user, seq: parameterDict["seq"]!.toInt()!, cpc: cpc, isClick: isClick, name: name))
    }
    
    return signalFromAPIURL(.GET, url: "http://igaw-hack.elasticbeanstalk.com/ssp/Exam/SelectAD", arguments: parameterDict, transform: selectAdDictionary)
  }
  
  //MARK: Private
  private func signalFromAPIURL<T: AnyObject>(method: Alamofire.Method, url: String, arguments: [String:AnyObject], transform: (NSDictionary) -> T) -> RACSignal {
  
    
    println("signalFromAPIURL : \(url),  \(arguments)")
    
    let scheduler = RACScheduler(priority: RACSchedulerPriorityBackground)
    
    return RACSignal.createSignal({ (subscriber: RACSubscriber!) -> RACDisposable! in
      
      let request = Alamofire.request(method, url, parameters: arguments).responseJSON(completionHandler: { (request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
        
        println("request : \(request)")
        println("response : \(response)")
        println("JSON : \(JSON)")
//        println("error : \(error)")
        
        println("error.code : \(error?.code) error.userInfo : \(error?.userInfo) error.domain : \(error?.domain)")
        
        
        //          let successSignal = self.rac_signalForSelector("")
        
        if error == nil {
          
          subscriber.sendNext(JSON)
          subscriber.sendCompleted()
        } else {
          subscriber.sendError(error)
        }
      })
      
      return RACDisposable(block: {
        request.cancel()
      })
      // transform with the given function
    }).mapAs(transform)
  
  }
}