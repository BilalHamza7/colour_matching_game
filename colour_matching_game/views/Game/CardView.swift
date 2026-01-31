import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            // BACK: Shown when !isFaceUp
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue)
                .opacity(card.isFaceUp || card.isMatched ? 0 : 1)
            
            // FRONT: Shown when isFaceUp
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 3)
                .opacity(card.isFaceUp || card.isMatched ? 1 : 0)
            
            if card.isFaceUp || card.isMatched {
                Image(systemName: card.symbol)
                    .font(.system(size: 30, weight: .bold))
                    // Ensure this uses the card's specific color property
                    .foregroundColor(card.isBomb ? .black : card.color)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .rotation3DEffect(
            .degrees(card.isFaceUp || card.isMatched ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}
