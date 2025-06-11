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
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct RideWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RideWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
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
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension RideWidgetAttributes {
    fileprivate static var preview: RideWidgetAttributes {
        RideWidgetAttributes(name: "World")
    }
}

extension RideWidgetAttributes.ContentState {
    fileprivate static var smiley: RideWidgetAttributes.ContentState {
        RideWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: RideWidgetAttributes.ContentState {
         RideWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: RideWidgetAttributes.preview) {
   RideWidgetLiveActivity()
} contentStates: {
    RideWidgetAttributes.ContentState.smiley
    RideWidgetAttributes.ContentState.starEyes
}
