struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            // Face Down
            RoundedRectangle(cornerRadius: 12)
                .fill(card.isFaceUp || card.isMatched ? Color.white : Color.blue)
                .shadow(radius: 3)
            
            // Face Up (Symbol and Color)
            if card.isFaceUp || card.isMatched {
                Image(systemName: card.symbol)
                    .font(.system(size: 30))
                    .foregroundColor(card.isBomb ? .black : card.color)
            }
        }
        .aspectRatio(1, contentMode: .fit) // Keeps cards square
        .rotation3DEffect(
            .degrees(card.isFaceUp || card.isMatched ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .opacity(card.isMatched ? 0.4 : 1.0) // Dim matched cards
    }
}