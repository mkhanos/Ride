//
//  RideWidgetBundle.swift
//  RideWidget
//
//  Created by Momo Khan on 6/11/25.
//

import WidgetKit
import SwiftUI

@main
struct RideWidgetBundle: WidgetBundle {
    var body: some Widget {
        RideWidget()
        RideWidgetControl()
        RideWidgetLiveActivity()
    }
}
