import SwiftUI
class Question: ObservableObject {
    var QuestionList: [String] = [
        "Which is the largest planet in our solar system?",
        "Who was the first Prime Minister of India?",
        "Which element has the chemical symbol 'O'?",
        "What is the capital of Japan?",
        "Which continent is known as the 'Dark Continent'?",
        "Which is the longest river in the world?",
        "Who invented the light bulb?",
        "What is the currency of the United Kingdom?",
        "Which gas do plants absorb from the atmosphere?",
        "In which year did India gain independence?"
    ]
}
class Options: ObservableObject {
    var optionList: [[String]] = [
        ["A) Earth","B) Mars", "C) Jupiter","D) Saturn"],
        ["A) Mahatma Gandhi", "B) Jawaharlal Nehru", "C) Sardar Vallabhbhai Patel", "D) Subhas Chandra Bose"],
        ["A) Gold", "B) Oxygen", "C) Osmium", "D) Oxide"],
        ["A) Seoul", "B) Beijing", "C) Tokyo", "D) Bangkok"],
        ["A) Asia", "B) Africa", "C) Australia", "D) Europe"],
        ["A) Amazon", "B) Ganga", "C) Nile", "D) Yangtze"],
        ["A) Isaac Newton", "B) Albert Einstein", "C) Thomas Edison", "D) Galileo Galilei"],
        ["A) Dollar", "B) Euro", "C) Pound sterling", "D) Franc"],
        ["A) Oxygen", "B) Nitrogen", "C) Carbon Dioxide", "D) Hydrogen"],
        ["A) 1945", "B) 1950", "C) 1947", "D) 1930"]
    ]
    var amswerList: [String] = [
        "C) Jupiter",
        "B) Jawaharlal Nehru",
        "B) Oxygen",
        "C) Tokyo",
        "B) Africa",
        "C) Nile",
        "C) Thomas Edison",
        "C) Pound sterling",
        "C) Carbon Dioxide",
        "C) 1947"
    ]
}
struct game: View {
    @StateObject var question = Question()
    @StateObject var options = Options()
    @State var optionButtonColor: [[Color]] = Array(repeating: Array(repeating: .blue, count: 4), count: 10)
    @State var isAnswered: [Bool] = Array(repeating: false, count: 10)
    @State var score: Int = 0
    @State var answerdeQuestion: [Int] = Array(repeating: 0, count: 10)
    var body: some View {
        VStack {
            VStack{
                Text("number of questions: \(answerdeQuestion.filter({$0 == 1}).count)/\(answerdeQuestion.count)")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .frame(width: 280, height: 30, alignment: .center)
                    .background(Color.cyan)
                    .cornerRadius(40)
                Button{
                    score = 0
                    answerdeQuestion = Array(repeating: 0, count: 10)
                    isAnswered = Array(repeating: false, count: 10)
                    optionButtonColor = Array(repeating: Array(repeating: .blue, count: 4), count: 10)
                    
                    
                } label: {
                    Text("Restart")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .frame(width: 140, height: 50, alignment: .center)
                        .background(Color.red)
                        .cornerRadius(40)
                        .offset(x: 130, y: 13)
                     
                }
            }
            .frame(width: 100, height: 100, alignment: .center)
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<question.QuestionList.count, id: \.self) { index in
                        VStack(spacing: 30) {
                            Text("Question No: \(index+1)")
                            Text(question.QuestionList[index])
                                .font(.title3)
                                .fontWeight(.bold)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .frame(width: 350, height: 50, alignment: .center)
                            VStack(spacing: 20) {
                                ForEach(0..<4, id: \.self) { i in
                                    Button {
                                        if !isAnswered[index] {
                                            isAnswered[index] = true
                                            if options.optionList[index][i] == options.amswerList[index] {
                                                answerdeQuestion[index] = 1
                                                optionButtonColor[index][i] = .green
                                                score += 1
                                            } else {
                                                optionButtonColor[index][i] = .red
                                                answerdeQuestion[index] = 1
                                            }
                                        }
                                    } label: {
                                        Text(options.optionList[index][i])
                                            .frame(width: 210, height: 30)
                                            .padding(10)
                                            .foregroundColor(.white)
                                            .background(optionButtonColor[index][i])
                                            .cornerRadius(25)
                                    }
                                    .disabled(isAnswered[index])
                                }
                            }
                        }
                        .padding(40)
                        .padding(.bottom, 40)
                        .padding(.top, 40)
                        .frame(width: 450, height: 500)
                        .background(Color.cyan.opacity(0.3))
                        .cornerRadius(60)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            
            HStack {
                Spacer()
                Text("Score: \(score)")
                    .font(.title)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.black)
            VStack {
                BannerAdView()
            }
            .frame(width: UIScreen.main.bounds.width, height: 50)
        }
    }
}

struct game_Previews: PreviewProvider {
    static var previews: some View {
        game()
    }
}
