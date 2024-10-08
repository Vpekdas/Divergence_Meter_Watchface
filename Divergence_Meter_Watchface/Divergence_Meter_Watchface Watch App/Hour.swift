//
//  Hour.swift
//  Divergence_Meter_Watchface Watch App
//
//  Created by Volkan Pekdas on 05/10/2024.
//

import SwiftUI

struct Hour: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive: Bool = false
    @State private var formattedTime: String = formatTime()
    @State private var showDivergence: Bool = true

    var body: some View {
        VStack {
            ZStack {
                Text(formattedTime)
                    .font(Font.custom("BONX-Frame", size: 42.0))
                    .foregroundStyle(.yellow)
                Text(formattedTime)
                    .font(Font.custom("BONX-Silhouette", size: 42.0))
                    .foregroundStyle(.red)
                    .opacity(0.30)
                Divergence()
            }
        }
        // .onChange(of: scenePhase) { _, newPhase in
        //     isActive = isScreenActive(scenePhase: newPhase)
        // }
        // .onAppear {
        //     if isActive {
        //         setTimeout(delay: 5.0) {}
        //     }
        // }
    }
}

func setTimeout(delay: TimeInterval, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: action)
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
