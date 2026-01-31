struct GameView: View {
    @State private var viewModel: GameViewModel
    
    init(mode: GameMode) {
        _viewModel = State(initialValue: GameViewModel(mode: mode))
    }

    // This makes the grid adapt to 3, 4, or 5 columns automatically
    var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 10), count: viewModel.gridSize)
    }

    var body: some View {
        VStack {
            // Header: Level, Score, and Timer
            HStack {
                VStack(alignment: .leading) {
                    Text("Level \(viewModel.currentLevel)").font(.caption).bold()
                    Text("Score: \(viewModel.score)").font(.title3)
                }
                Spacer()
                // Component we will build next
                TimerView(timeRemaining: viewModel.timeRemaining) 
            }
            .padding()

            Spacer()

            // The Playable Grid
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                viewModel.choose(card)
                            }
                        }
                        // Apple Accessibility Guideline: Descriptive labels
                        .accessibilityLabel(AccessibilityManager.label(for: card))
                }
            }
            .padding()

            Spacer()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(viewModel.mode.rawValue)
        .overlay {
            // Level Complete or Game Over Overlays
            if case .gameOver(let reason) = viewModel.gameState {
                GameOverView(reason: reason, score: viewModel.score) {
                    viewModel.setupLevel() // Reset
                }
            }
        }
    }
}