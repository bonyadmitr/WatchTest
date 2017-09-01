//
//  ComplicationController.swift
//  WatchTest WatchKit Extension
//
//  Created by Yaroslav Bondar VironIT on 28.08.17.
//  Copyright © 2017 VironIT. All rights reserved.
//

import ClockKit

// TODO: Check CLKComplicationDataSource
/// iPhone to the Watch app 50 complication transfers a day
class ComplicationController: NSObject, CLKComplicationDataSource {
     
    // MARK: - Timeline Configuration
    
    let timeUnit: TimeInterval = 1 * 60 * 60
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        print("- ComplicationController getTimelineStartDate", complication)
        handler(Date().addingTimeInterval(-4 * timeUnit))
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        print("- ComplicationController getTimelineEndDate", complication)
        handler(Date().addingTimeInterval(4 * timeUnit))
    }
    
    /// can be hidden private or sensitive information on locked screen
    /// showOnLockScreen is default
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    /// how often to refresh the complication data
    func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
        handler(Date(timeIntervalSinceNow: 10))
    }
    
    
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        print("- ComplicationController getCurrentTimelineEntry", complication)
        // Call the handler with the current timeline entry
        
        if complication.family == .circularSmall {
            let template = CLKComplicationTemplateCircularSmallRingText()
            template.textProvider = CLKSimpleTextProvider(text: "\(10)")
            template.fillFraction = 1 //Float(7) / 10
            template.ringStyle = .closed
            
            let timelineEntry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(timelineEntry)
            
        } else {
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        print("- ComplicationController getTimelineEntries before date", date, Date(), limit)
        // Call the handler with the timeline entries prior to the given date
        
        
        if complication.family == .circularSmall {
            
            var timeLineEntryArray = [CLKComplicationTimelineEntry]()
            var nextDate = Date(timeIntervalSinceNow: -timeUnit)
            
            for i in 1...3 {
                
                let template = CLKComplicationTemplateCircularSmallRingText()
                template.textProvider = CLKSimpleTextProvider(text: "\(10 - i)")
                template.fillFraction = 1 - Float(i) / 10
                template.ringStyle = .closed
                
                let timelineEntry = CLKComplicationTimelineEntry(date: nextDate, complicationTemplate: template)
                timeLineEntryArray.append(timelineEntry)
                nextDate = nextDate.addingTimeInterval(-timeUnit)
            }
            
            handler(timeLineEntryArray)
            
        } else {
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        print("- ComplicationController getTimelineEntries after date", date, Date(), limit)
        // Call the handler with the timeline entries after to the given date
        
        if complication.family == .circularSmall {
            
            var timeLineEntryArray = [CLKComplicationTimelineEntry]()
            var nextDate = Date(timeIntervalSinceNow: timeUnit)
            
            for i in 1...3 {
                
                let template = CLKComplicationTemplateCircularSmallRingText()
                template.textProvider = CLKSimpleTextProvider(text: "\(i)")
                template.fillFraction = Float(i) / 10
                template.ringStyle = .closed
                
                let timelineEntry = CLKComplicationTimelineEntry(date: nextDate, complicationTemplate: template)
                timeLineEntryArray.append(timelineEntry)
                nextDate = nextDate.addingTimeInterval(timeUnit)
            }
            
            handler(timeLineEntryArray)
            
        } else {
            handler(nil)
        }
        
    }
    
    
    
    // MARK: - Placeholder Templates
    
    /// when data is not populated + when customizing the clock face
    /// This method will be called once per supported complication, and the results will be cached
    /// Read quick help of this method
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        print("- ComplicationController getLocalizableSampleTemplate", complication)
        
        /// When building your templates, you can specify localized placeholder text using a simple text provider
        /// The keys you use for your simple text provider must appear in a localized strings file named ckcomplication.strings.
        /// This strings file should also be in your WatchKit extension bundle
        //CLKSimpleTextProvider.localizableTextProvider(withStringsFileTextKey: "AKey")
        
        let template: CLKComplicationTemplate?
        switch complication.family {
        case .modularSmall:
            template = nil
        case .modularLarge:
            template = nil
        case .utilitarianSmall:
            template = nil
        case .utilitarianLarge:
            template = nil
        case .circularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "--")
            modularTemplate.fillFraction = 0.9
            modularTemplate.ringStyle = .closed
            template = modularTemplate
        /// @available(watchOS 3.0, *)
        case .utilitarianSmallFlat:
            template = nil
        /// @available(watchOS 3.0, *)
        case .extraLarge:
            template = nil
        }
        handler(template)
    }
    
}
