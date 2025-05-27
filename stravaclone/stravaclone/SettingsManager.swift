//
//  SettingsManager.swift
//  stravaclone
//
//  Created by Momo Khan on 5/27/25.
//

import Foundation

final class SettingsManager: ObservableObject {
    @Published var isMetric: Bool {
        didSet {
            UserDefaults.standard.set(isMetric, forKey: "isMetric")
        }
    }
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    init() {
        self.isMetric = UserDefaults.standard.bool(forKey: "isMetric")
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
}
