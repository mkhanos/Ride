//
//  RideWidgetLiveActivity.swift
//  RideWidget
//
//  Created by Momo Khan on 6/11/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct RideWidgetAttributes: ActivityAttributes {
    let ride: Ride
    
    struct ContentState: Codable, Hashable {
        let rideDistance: Double
        let rideTime: Double
        let rideSpeed: Double
    }
}

struct RideWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RideWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.rideDistance)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.rideDistance)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.rideDistance)")
            } minimal: {
                Text("\(context.state.rideDistance)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension RideWidgetAttributes {
    fileprivate static var preview: RideWidgetAttributes {
        RideWidgetAttributes(ride: Ride.mock)
    }
}

//extension RideWidgetAttributes.ContentState {
//    fileprivate static var smiley: RideWidgetAttributes.ContentState {
//        RideWidgetAttributes.ContentState(emoji: "😀")
//     }
//     
//     fileprivate static var starEyes: RideWidgetAttributes.ContentState {
//         RideWidgetAttributes.ContentState(emoji: "🤩")
//     }
//}
//
//#Preview("Notification", as: .content, using: RideWidgetAttributes.preview) {
//   RideWidgetLiveActivity()
//} contentStates: {
//    RideWidgetAttributes.ContentState.smiley
//    RideWidgetAttributes.ContentState.starEyes
//}
