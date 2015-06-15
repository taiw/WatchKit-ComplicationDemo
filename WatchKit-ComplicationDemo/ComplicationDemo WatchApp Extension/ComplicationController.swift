//
//  ComplicationController.swift
//  ComplicationDemo WatchApp Extension
//
//  Created by TaiWei on 15/6/15.
//  Copyright © 2015年 TaiWei. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        // Current timeline entry
        var entry:CLKComplicationTimelineEntry?
        
        BTCData.shared.loadPrice( {price,error in
            
            if let p=price {
                switch complication.family {
                case .UtilitarianLarge:
                    let template=CLKComplicationTemplateUtilitarianLargeFlat()
                    
                    template.textProvider=CLKSimpleTextProvider(text: "BTC:$\(p.description)")
                    entry=CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
                    
                case .ModularLarge:
                    let template=CLKComplicationTemplateModularLargeStandardBody()
                    template.headerTextProvider=CLKSimpleTextProvider(text: "BitCoin:")
                    template.body1TextProvider=CLKSimpleTextProvider(text: "$\(p.description)")
                    template.body2TextProvider=CLKSimpleTextProvider(text: "")
                    
                    entry=CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
                
                default:
                    break
                }
                handler(entry)
            }
            else {
                handler(nil)
            }
        })
        
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
}
