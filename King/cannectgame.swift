import SwiftUI
import Foundation
import connect
@available(iOS 14.0, *)
struct ConnectGameView: View {
    @StateObject private var game = GameController()

    func colorForCoin(_ char: Character) -> Color {
        switch char {
        case "G": return .green
        case "R": return .red
        default: return .white
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 148/255, green: 241/255, blue: 200/255),
                Color(red: 0/255, green: 33/255, blue: 45/255),
            ]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Button {
                   // logOutUser()
                } label: {
                    Text("logout")
                        .padding(.top, 10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.red)
                        .cornerRadius(8)
                        .frame(width: 100, height: 10)
                        .offset(x: 150, y: -350)
                }

            }
            VStack(spacing: 16) {
                Text("Connect Four")
                    .font(.largeTitle)
                    .bold()

                if let winner = game.winner {
                    ZStack {
                        Text("\(winner) Wins!")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                            .contrast(5)
                    }
                    .frame(width: 200, height: 70)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                            Color(red: 148/255, green: 241/255, blue: 200/255),
                            Color(red: 0/255, green: 33/255, blue: 45/255),
                        ]), startPoint: .top, endPoint: .bottom)
                    )
                    .contrast(5)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    
                } else if game.isDraw {
                    ZStack{
                        Text("It's a Draw!")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                            .contrast(5)
                    }
                    .frame(width: 200, height: 70)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                            Color(red: 148/255, green: 241/255, blue: 200/255),
                            Color(red: 0/255, green: 33/255, blue: 45/255),
                        ]), startPoint: .top, endPoint: .bottom)
                    )
                    .contrast(5)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                } else {
                    Text("Current: \(game.currentPlayer.name) (\(game.currentPlayer.coin))")
                        .font(.title3)
                }

                VStack(spacing: 4) {
                    ForEach(0..<6, id: \.self) { row in
                        HStack(spacing: 4) {
                            ForEach(0..<7, id: \.self) { col in
                                Button(action: {
                                    if !game.gameOver && game.canPlayMove(column: col) {
                                        game.playMove(column: col)
                                    }
                                }) {
                                    Circle()
                                        .fill(colorForCoin(game.grid[row][col]))
                                        .frame(width: 40, height: 40)
                                        .overlay(Circle().stroke(Color.black, lineWidth: 1))
                                }
                                .disabled(!isTopEmptyCell(row: row, column: col) || game.gameOver)
                            }
                        }
                    }
                }
                .padding()
                .cornerRadius(12)

                Button("Reset Game") {
                    game.startNewGame()
                }
                .padding(.top, 10)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.red)
                .cornerRadius(8)
            }
            .padding()
            
            
        
        }
        VStack {
            BannerAdView()
        }
        .frame(width: UIScreen.main.bounds.width, height: 50)
        
    }

    func isTopEmptyCell(row: Int, column: Int) -> Bool {
        guard game.grid[row][column] == "_" else { return false }
        if row == 5 { return true }
        return game.grid[row + 1][column] != "_"
    }
}

#Preview {
    if #available(iOS 14.0, *) {
        ConnectGameView()
    }
    
}
