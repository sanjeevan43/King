import SwiftUI

struct TicTactoe: View {
    @StateObject private var game = TictactoeGame()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Text("Tic Tac Toe")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                TictactoeBoardView(game: game)
                
                if let winner = game.winner {
                    Text(winner == "Draw" ? "It's a Draw!" : "Player \(winner) Wins!")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                }
                
                Button("Restart") {
                    game.reset()
                }
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

struct TictactoeBoardView: View {
    @ObservedObject var game: TictactoeGame
    
    var body: some View {
        VStack {
            ForEach(0..<3, id: \..self) { row in
                HStack {
                    ForEach(0..<3, id: \..self) { col in
                        Button(action: {
                            game.play(row: row, col: col)
                        }) {
                            Text(String(game.board[row][col]))
                                .font(.system(size: 50, weight: .bold))
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                            
                            
                        }
                        .disabled(game.board[row][col] != "_" || game.winner != nil)
                    }
                }
            }
        }
        VStack {
            BannerAdView()
        }
        .frame(width: UIScreen.main.bounds.width, height: 70)
        .offset(y: 220)
   
    }
    
}

class TictactoeGame: ObservableObject {
    @Published var board: [[Character]] = Array(repeating: Array(repeating: "_", count: 3), count: 3)
    @Published var currentPlayer: Character = "X"
    @Published var winner: String? = nil
    
    func isWin() -> Bool {
        for i in 0..<3 {
            if board[i][0] != "_" && board[i][0] == board[i][1] && board[i][1] == board[i][2] {
                winner = String(board[i][0])
                return true
            }
            if board[0][i] != "_" && board[0][i] == board[1][i] && board[1][i] == board[2][i] {
                winner = String(board[0][i])
                return true
            }
        }
        if board[0][0] != "_" && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            winner = String(board[0][0])
            return true
        }
        if board[0][2] != "_" && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            winner = String(board[0][2])
            return true
        }
        return false
    }
    
    func isDraw() -> Bool {
        if !board.joined().contains("_") && winner == nil {
            winner = "Draw"
            return true
        }
        return false
    }
    
    func play(row: Int, col: Int) {
        if setCoin(row: row, col: col, coin: currentPlayer) {
            if isWin() {
                print("Player \(currentPlayer) wins!")
            } else if isDraw() {
                print("The game is a draw.")
            } else {
                switchPlayer()
                print("It's \(currentPlayer)'s turn.")
            }
        } else {
            print("Invalid move. Try again.")
        }
    }
    
    func setCoin(row: Int, col: Int, coin: Character) -> Bool {
        if row >= 0 && row < 3 && col >= 0 && col < 3 {
            if board[row][col] == "_" {
                board[row][col] = currentPlayer
                return true
            }
        }
        return false
    }
    
    func switchPlayer() {
        currentPlayer = (currentPlayer == "X") ? "O" : "X"
    }
    
    func reset() {
        board = Array(repeating: Array(repeating: "_", count: 3), count: 3)
        currentPlayer = "X"
        winner = nil
    }
    
}

#Preview {
    TicTactoe()
}
