//
//  RideWidget.swift
//  RideWidget
//
//  Created by Momo Khan on 6/11/25.
//

import WidgetKit
import SwiftData
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), ride: Ride.mock)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), ride: Ride.mock)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = [SimpleEntry(date: Date(), ride: Ride.mock)]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let ride: Ride
}

struct RideWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Ride Speed")
            Text("\(entry.ride.averageSpeed)")
        }
    }
}

struct RideWidget: Widget {
    let kind: String = "RideWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                RideWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                RideWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Current Ride Widget")
        .description("Look at stats for your current ride.")
    }
}

#Preview(as: .systemSmall) {
    RideWidget()
} timeline: {
    SimpleEntry(date: .now, ride: Ride.mock)
}

#Preview(as: .systemMedium) {
    RideWidget()
} timeline: {
    SimpleEntry(date: .now, ride: Ride.mock)
}

#Preview(as: .systemLarge) {
    RideWidget()
} timeline: {
    SimpleEntry(date: .now, ride: Ride.mock)
}
