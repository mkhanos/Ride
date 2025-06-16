//
//  Double+.swift
//  stravaclone
//
//  Created by Momo Khan on 5/26/25.
//

import Foundation

extension Double {
    var twoDecimalString: String {
        String(format: "%.2f", self)
    }
    
    var metersToMiles: String {
        let miles = self / 1609.344
        return String(format: "%.2f", miles)
    }
    
    var metersToKilometers: String {
        let km = self / 1000
        return String(format: "%.2f", km)
    }
    
    var localizedDistance: String {
        let distance = Measurement(value: self, unit: UnitLength.meters)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 2
        let miles = distance.converted(to: .miles)
        return formatter.string(from: miles)
    }
    
    var formattedTime: String {
        let totalSeconds = Int(self)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let secs = totalSeconds % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else if minutes > 0 {
            return "\(minutes)m \(secs)s"
        } else {
            return "\(secs)s"
        }
    }
}
