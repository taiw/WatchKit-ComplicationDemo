//
//  BTCData.swift
//  BitcoinComplication for AppleWatch
//
//  Created by TaiWei on 15/6/15.
//  Copyright © 2015年 TaiWei. All rights reserved.
//

import Foundation

public typealias CompletionCallBackBlock = (price: NSNumber?, error: NSError?) -> ()

class BTCData : NSObject{
    
    class var shared:BTCData {
        struct Static {
            static let instance:BTCData=BTCData()
        }
        return Static.instance
    }
    
    func loadPrice(completion:CompletionCallBackBlock) {
        var price:NSNumber?
        let URL = "https://api.bitcoinaverage.com/ticker/USD"
        let request = NSURLRequest(URL: NSURL(string: URL)!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error in
            if error == nil {
                do {
                    let responseDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    price =  responseDict["24h_avg"] as? NSNumber
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(price: price, error: nil)
                    })
                }
                catch {
                    NSLog("Data Error!")
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(price: price, error: error)
                })
            }
        })
        task!.resume()
        
    }
    
}
