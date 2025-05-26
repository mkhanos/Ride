//
//  VerticalTextLabel.swift
//  stravaclone
//
//  Created by Momo Khan on 5/26/25.
//

import SwiftUI

struct VerticalTextLabel: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(subtitle)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    VerticalTextLabel(title: "Distance", subtitle: "6.77 mi")
}
