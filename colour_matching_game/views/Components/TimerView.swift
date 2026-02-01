import SwiftUI

struct TimerView: View {
    let timeRemaining: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .opacity(0.3)
                .foregroundColor(.gray)
            
            Text("\(Int(timeRemaining))")
                .font(.system(.body, design: .monospaced))
                .bold()
        }
        .frame(width: 50, height: 50)
        .foregroundColor(timeRemaining > 10 ? .blue : .red)
    }
}
