//
//  SharedModelContainer.swift
//  stravaclone
//
//  Created by Momo Khan on 6/12/25.
//

import Foundation
import SwiftData

var sharedModelContainer: ModelContainer = {
    let schema = Schema([
        Ride.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema)
    
    do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()
