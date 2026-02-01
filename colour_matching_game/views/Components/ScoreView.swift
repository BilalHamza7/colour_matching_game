import SwiftUI

struct ScoreView: View {
    let score: Int
    let level: Int
    let timeRemaining: Double

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("LEVEL \(level)")
                    .font(.caption)
                    .fontWeight(.black)
                    .foregroundColor(.secondary)
                Text("\(score)")
                    .font(.system(.title, design: .rounded))
                    .bold()
            }
            
            Spacer()
            
            // Timer Circle
            ZStack {
                Circle()
                    .stroke(lineWidth: 4)
                    .opacity(0.2)
                    .foregroundColor(.gray)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(timeRemaining / 60.0)) // Assuming 60s max
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .foregroundColor(timeRemaining < 10 ? .red : .blue)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear, value: timeRemaining)

                Text("\(Int(timeRemaining))")
                    .font(.system(.body, design: .monospaced))
                    .bold()
            }
            .frame(width: 50, height: 50)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(15)
    }
}