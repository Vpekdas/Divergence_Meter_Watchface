//
//  Hour.swift
//  Divergence_Meter_Watchface Watch App
//
//  Created by Volkan Pekdas on 05/10/2024.
//

import SwiftUI

struct Hour: View {
    @Environment(\.scenePhase) var scenePhase

    // State so we can use .onChange
    @State private var isActive: Bool = true
    @State private var isAnimationFinished: Bool = false

    var body: some View {
        ZStack {
            if isAnimationFinished {
                let formattedTime = formatTime()
                Text(formattedTime)
                    .font(Font.custom("BONX-Frame", size: 42.0))
                    .foregroundStyle(.yellow)
                Text(formattedTime)
                    .font(Font.custom("BONX-Silhouette", size: 42.0))
                    .foregroundStyle(.red)
                    .opacity(0.30)
                Text(formattedTime)
                    .font(Font.custom("BONX-Medium", size: 42.0))
                    .foregroundStyle(.orange)
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            isActive = isScreenActive(scenePhase: newPhase)
        }
        .onAppear {
            if isActive {
                setTimeout(delay: 5.0) {
                    isAnimationFinished = true
                }
            }
        }
    }
}

func setTimeout(delay: TimeInterval, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: action)
}

func generateRandomNumber() -> String {
    let minDivergence: Float = 0.337187
    let maxDivergence: Float = 1.048596
    let number = Float.random(in: minDivergence ... maxDivergence)

    return number.description
}

func formatTime() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "HH:mm:ss"

    return dateFormatter.string(from: date)
}

func isScreenActive(scenePhase: ScenePhase) -> Bool {
    switch scenePhase {
    case .active:
        print("Active")
        return true

    case .inactive:
        print("Inactive")
        return false

    default:
        return false
    }
}

#Preview {
    Hour()
}
