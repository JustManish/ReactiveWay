//
//  DateExtension.swift
//  jaldilive
//
//  Created by Admin on 02/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

extension Date
{
    func dateToString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: self)
    }
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return "active \(formatter.localizedString(for: self, relativeTo: Date()))"
    }
}
extension String {
    
    func getFormatedDate(fromFormat:String,toFormat:String,dateString:String) -> String {
            
            var formater = DateFormatter()
            formater.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            formater.dateFormat = fromFormat
            let date = formater.date(from: dateString)
            formater=DateFormatter()
            formater.dateFormat=toFormat
           // formater.timeZone = TimeZone(abbreviation: "UTC")
            formater.timeZone = NSTimeZone.local
            if date == nil{
                return ""
            }else{
                return formater.string(from: date!)
            }
        }
    
}
extension StringProtocol {
    func masked(_ n: Int = 5, reversed: Bool = false) -> String {
        let mask = String(repeating: "•", count: Swift.max(0, count-n))
        return reversed ? mask + suffix(n) : prefix(n) + mask
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
