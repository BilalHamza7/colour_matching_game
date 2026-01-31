enum GameState {
    case idle
    case playing
    case paused
    case levelComplete
    case gameOver(reason: String) // e.g., "Hit a Bomb!" or "Time's Up"
}