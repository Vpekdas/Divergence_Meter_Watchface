import Foundation
import SwiftUI

struct Divergence: View {
    @State private var currentHour: String = formatTime()
    @State private var isSpinning: Bool = false

    var body: some View {
        HStack {
            ForEach(0 ..< currentHour.count, id: \.self) { index in
                Text(String(currentHour[currentHour.index(currentHour.startIndex, offsetBy: index)]))
                    .font(Font.custom("BONX-Medium", size: 42.0))
                    .foregroundStyle(.orange)
            }
        }
        .onAppear {
            spinDigits(correctChars: currentHour, delay: 0.5)
        }
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

#Preview {
    Divergence()
}
