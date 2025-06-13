import SwiftUI

struct MainMenu: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink(destination: game()) {
                    Text("Quiz Game")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: TableView()) {
                    Text("Result Table")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: TicTactoe()) {
                    Text("Tic tac toe")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                NavigationLink(destination: ConnectGameView()) {
                    Text("connect 4 game")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Main Menu")
            VStack {
                BannerAdView()
            }
            .frame(width: UIScreen.main.bounds.width, height: 50)
        }
    }
}

#Preview {
    MainMenu()
}
