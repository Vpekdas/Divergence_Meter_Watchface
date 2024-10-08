import Foundation
import SwiftUI

struct Divergence: View {
    @State private var currentHour: String
    @State private var currentDate: String

    init() {
        let currentDate = Date()
        _currentHour = State(initialValue: formatTime(date: currentDate))
        _currentDate = State(initialValue: formatDate(date: currentDate))
    }

    var body: some View {
        VStack {
            ZStack {
                Text(currentHour)
                    .font(Font.custom("BONX-Frame", size: 42.0))
                    .foregroundStyle(.yellow)
                Text(currentHour)
                    .font(Font.custom("BONX-Silhouette", size: 42.0))
                    .foregroundStyle(.red)
                    .opacity(0.30)
                Text(currentHour)
                    .font(Font.custom("BONX-Medium", size: 42.0))
                    .foregroundStyle(.orange)
            }
            .onAppear {
                spinDigits(correctChars: currentHour, delay: 0.5)
            }
        }
        Text(currentDate)
            .font(Font.custom("BONX-Medium", size: 24.0))
            .foregroundStyle(.orange)
    }

    func spinDigits(correctChars: String, delay: TimeInterval) {
        var timers: [Timer] = []

        for (index, char) in correctChars.enumerated() {
            let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                let randomDigit = Int.random(in: 0 ..< 10)
                let randomChar = Character("\(randomDigit)")
                let startIndex = currentHour.index(currentHour.startIndex, offsetBy: index)
                currentHour.replaceSubrange(startIndex ... startIndex, with: String(randomChar))
            }

            timers.append(timer)

            DispatchQueue.main.asyncAfter(deadline: .now() + delay * Double(index + 1)) {
                timer.invalidate()
                let startIndex = currentHour.index(currentHour.startIndex, offsetBy: index)
                currentHour.replaceSubrange(startIndex ... startIndex, with: String(char))
            }
        }
    }
}

func formatTime(date: Date) -> String {
    return date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits).second(.twoDigits))
}

func formatDate(date: Date) -> String {
    return date.formatted(.dateTime.weekday(.abbreviated).day().month().year())
}

#Preview {
    Divergence()
}
