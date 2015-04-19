//
//  ViewController.swift
//  AdSSPOptimazationLogic
//
//  Created by songwonje on 2015. 4. 18..
//  Copyright (c) 2015년 songwonje. All rights reserved.
//

import UIKit

import Alamofire

class ViewController: UIViewController {

  
  //MARK: Properties
  @IBOutlet var adRequestButton: UIButton!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBOutlet var roundLabel: UILabel!
  @IBOutlet var seqLabel: UILabel!
  @IBOutlet var cpcLabel: UILabel!
  @IBOutlet var totalClickLabel: UILabel!
  @IBOutlet var totalNoClickLabel: UILabel!
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    self.bindViewModel()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }

  
  //MARK: Private
  private func bindViewModel() {

    
    let viewModelServices = ViewModelServicesImpl()
    let viewModel = ViewModel(services: viewModelServices)
    
    
    viewModel.adRequestCommand.executing.NOT() ~> RAC(self.activityIndicator, "hidden")
    
    self.adRequestButton.rac_command = viewModel.adRequestCommand
    
    
    let numberFormatter = NSNumberFormatter()
    numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
    
    RACObserve(viewModel, "round").subscribeNext { (d: AnyObject!) -> Void in
  
      self.roundLabel.text = "round : \(d)"
    }
    
    RACObserve(viewModel, "seq").subscribeNext { (d: AnyObject!) -> Void in
      
      self.seqLabel.text = "seq : \(numberFormatter.stringFromNumber(d as! Int)!)"
      
      println("seq : \(numberFormatter.stringFromNumber(d as! Int)!)")
    }
    
    RACObserve(viewModel, "totalCPC").subscribeNext { (d: AnyObject!) -> Void in
      
      
      self.cpcLabel.text = "revenue : \(numberFormatter.stringFromNumber(d as! Int)!)"
    }
    
    RACObserve(viewModel, "totalClick").subscribeNext { (d: AnyObject!) -> Void in
      
      self.totalClickLabel.text = "click : \(numberFormatter.stringFromNumber(d as! Int)!)"
    }
    
    RACObserve(viewModel, "totalNoClick").subscribeNext { (d: AnyObject!) -> Void in
      
      self.totalNoClickLabel.text = "no click: \(numberFormatter.stringFromNumber(d as! Int)!)"
    }
    
    
    
  }
}

