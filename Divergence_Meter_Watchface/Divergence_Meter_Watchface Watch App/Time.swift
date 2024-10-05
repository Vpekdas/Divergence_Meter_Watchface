//
//  Time.swift
//  Divergence_Meter_Watchface Watch App
//
//  Created by Volkan Pekdas on 05/10/2024.
//

import SwiftUI

struct Hour: View {
    var body: some View {
        ZStack {
            Text(formatTime())
                .font(Font.custom("BONX-Frame", size: 42.0))
                .foregroundStyle(.yellow)
            Text(formatTime())
                .font(Font.custom("BONX-Silhouette", size: 42.0))
                .foregroundStyle(.red)
                .opacity(0.30)
            Text(formatTime())
                .font(Font.custom("BONX-Medium", size: 42.0))
                .foregroundStyle(.orange)
        }
    }
}

func formatTime() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "HH:mm:ss"

    return dateFormatter.string(from: date)
}

#Preview {
    Hour()
}
