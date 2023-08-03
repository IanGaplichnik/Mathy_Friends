//
//  ContentView.swift
//  D35_Multiplication_Table
//
//  Created by MacBook on 26.7.2023.
//

import SwiftUI

struct NextQuestionButton: View {
    let nextQuestion: () -> Void
    let questionsAsked: Int
    let amountOfQuestions: Int
    let questionAnswered: Bool
    var buttonText: String {
        if questionsAsked + 1 == amountOfQuestions
        {
            return "Finish"
        } else {
            return "Next"
        }
    }

    var body: some View {
        Button() {
            nextQuestion()
        } label: {
            Text(buttonText)
                .font(.custom("chalkboardse", size: 20))
                .frame(width: 55)
                .padding(.vertical, 30)
                .padding(.horizontal, 60)
                .background(Color(red: 1, green: 0.91, blue: 0.72))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .foregroundColor(.black)
                .shadow(color: Color(red: 0.37, green: 0.37, blue: 0.37), radius: 2, y: 15)
        }
        .opacity(questionAnswered ? 1 : 0)
        .animation(.easeInOut, value: questionAnswered)
    }
}

struct TotalScore: View {
    var score: Int

    var body: some View {
        Text("Total score: \(score)")
            .font(
                .custom("Fuzzy Bubbles", size: 20)
            )
            .foregroundColor(.white)
    }
}

struct StartScreenWhichTableText: View {
    var body: some View {
        Text("Which table do you want to practice?")
            .font(
                .custom("chalkboardse", size: 14)
                    .bold()
            )
            .padding(.top, 28)
            .padding(.bottom, 9)
    }
}

struct StartScreenMainLogo: View {
    var body: some View {
        Text("Mathy Friends")
            .font(
                .custom("Fuzzy Bubbles", size: 40)
            )
            .foregroundColor(.white)
            .shadow(radius: 5)
    }
}

struct StartScreenAmountOfQuestionsText: View {
    var body: some View {
        Text("Select amount of questions")
            .font(
                .custom("chalkboardse", size: 14)
                    .bold()
            )
            .padding(.top, 14)
            .padding(.bottom, 9)
    }
}

struct StartButton: View {
    var startGame: () -> Void

    var body: some View {
        Button() {
            startGame()
        } label: {
            Text("Start")
                .font(
                    .custom("chalkboardse", size: 28)
                        .bold()
                )
                .padding(.horizontal, 60)
                .padding(.vertical, 20)
        }
        .background(Color(red: 0.61, green: 0.37, blue: 1))
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(radius: 10)
    }
}

struct StartScreenTablePickerStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top, 9)
            .padding(.bottom, 14)
            .padding(.horizontal, 30)
            .cornerRadius(20)
            .background(Color(red: 0.61, green: 0.37, blue: 1))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .accentColor(.white)
            .shadow(radius: 2)

    }
}

struct StartScreenInfoBoxStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.regularMaterial)
            .frame(maxWidth:.infinity)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .padding(23)
            .shadow(radius: 2)
    }
}

struct AnswerButtonStyle: ViewModifier {
    let questionAnswered: Bool
    let number: Int
    let tappedButton: Int

    func body(content: Content) -> some View {
        content
            .disabled(questionAnswered)
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
            .shadow(color: Color(red: 0.37, green: 0.37, blue: 0.37), radius: 2, y: number == tappedButton ? 0 : 15)
            .offset(y: number == tappedButton ? 0 : -20)
            .animation(.default, value: tappedButton)
    }
}

struct AnswerButtonTextStyle: ViewModifier {
    let questionAnswered: Bool
    let number: Int
    let correctAnswerIndex: Int

    func body(content: Content) -> some View {
        content
            .font(.custom("chalkboardse", size: 31))
            .frame(width: 55)
            .padding(.vertical, 47)
            .padding(.horizontal, 47)
            .background(!questionAnswered ? Color.defaultButtonColor : (number == correctAnswerIndex ? Color.correctButtonColor : Color.wrongButtonColor))
            .clipShape(Circle())
            .foregroundColor(.black)
    }
}

struct GenerateAnswerButtons: View {
    let correctAnswerIndex: Int
    let tappedButton: Int
    let questionAnswered: Bool
    let answerChosen: (Int) -> Void
    let buttonAnswers: [Int]

    var body: some View {
        ForEach(0..<2) { row in
            HStack{
                ForEach(0..<2) { column in
                    Button {
                        answerChosen(row*2+column)
                    } label: {
                        Text("\(buttonAnswers[row*2+column])")
                            .answerButtonTextStyled(questionAnswered: questionAnswered,
                                                    number: row*2+column,
                                                    correctAnswerIndex: correctAnswerIndex
                            )
                    }
                    .answerButtonStyled(questionAnswered: questionAnswered,
                                        number: row*2+column,
                                        tappedButton: tappedButton)
                }
            }
        }
    }
}

extension View {
    func startScreenQuestionBoxStyled() -> some View {
        modifier(StartScreenInfoBoxStyle())
    }

    func startScreenTablePickerStyled() -> some View {
        modifier(StartScreenTablePickerStyle())
    }

    func answerButtonStyled(questionAnswered: Bool, number: Int, tappedButton: Int) -> some View {
        modifier(AnswerButtonStyle(questionAnswered: questionAnswered, number: number, tappedButton: tappedButton))
    }

    func answerButtonTextStyled(questionAnswered: Bool, number: Int, correctAnswerIndex: Int) -> some View {
        modifier(AnswerButtonTextStyle(questionAnswered: questionAnswered, number: number, correctAnswerIndex: correctAnswerIndex))
    }
}

extension Color {
    static let defaultButtonColor = Color("defaultButton")
    static let wrongButtonColor = Color("wrongButton")
    static let correctButtonColor = Color("correctButton")
    static let purpleBackground = Color("kidPurple")
}

struct ContentView: View {
    @State private var gameStarted = false
    @State private var questionAnswered = false
    @State private var questionsAmountChosen: Int = 5
    @State private var multiplicationTable: Int = 2
    @State private var score = 0
    @State private var alertShowing = false

    @State private var correctAnswerIndex = -1
    @State private var tappedButton = -1


    @State private var questionsAsked = 0
    private var amountOfQuestions = [5, 10, 15]
    @State private var buttonAnswers = [Int]()

    func restartGame() {
        gameStarted = false
        questionAnswered = false
        score = 0
        correctAnswerIndex = -1
        tappedButton = -1
        questionsAsked = 0
    }

    func buttonAnswersGenerator() -> [Int] {
        var fakeAnswer: Int = 0
        var buttonAnswers = [Int]()

        for _ in 0...2 {
            repeat {
                fakeAnswer = Int.random(in: (answers[questionsAsked] - 10)..<(answers[questionsAsked] + 10))
                if fakeAnswer < 0 {
                    fakeAnswer *= -1
                }
            } while (fakeAnswer == answers[questionsAsked] || buttonAnswers.contains(fakeAnswer))
            buttonAnswers.append(fakeAnswer)
        }
        correctAnswerIndex = Int.random(in: 0...3)
        buttonAnswers.insert(answers[questionsAsked], at: correctAnswerIndex)
        return buttonAnswers
    }

    @State private var questions = [Int]()
    @State private var answers = [Int]()

    func startGame() {
        gameStarted = true
        questions.removeAll()
        answers.removeAll()
        for i in 0..<questionsAmountChosen {
            if questionsAmountChosen == 5 {
                var answer: Int
                repeat {
                    answer = Int.random(in: 2...9)
                } while (questions.contains(answer))
                questions.append(answer)
            } else {
                questions.append(Int.random(in: 2...9))
            }
            answers.append(questions[i] * multiplicationTable)
        }
        buttonAnswers = buttonAnswersGenerator()
    }

    func answerChosen(numberOfButton: Int) {
        tappedButton = numberOfButton
        if numberOfButton == correctAnswerIndex {
            score += 1
        }
        questionAnswered = true
    }

    func nextQuestion() {
        if questionsAsked + 1 != questionsAmountChosen {
            questionsAsked += 1
            buttonAnswers = buttonAnswersGenerator()
        } else {
            alertShowing = true
        }
        questionAnswered = false
        tappedButton = -1
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color.purpleBackground.ignoresSafeArea()
                Image("MathyFriendsBackground")
                    .renderingMode(.original)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                if !gameStarted {
                    VStack(spacing: 60) {
                        Spacer()
                        StartScreenMainLogo()
                        VStack() {
                            StartScreenWhichTableText()
                            Picker("Table of...", selection: $multiplicationTable) {
                                ForEach(2..<10, id: \.self) { table in
                                    Text("\(table)")
                                }
                            }
                            .startScreenTablePickerStyled()

                            Divider()
                                .padding(.vertical, 14)
                                .padding(.horizontal, 24)

                            StartScreenAmountOfQuestionsText()
                            Picker("Select", selection: $questionsAmountChosen) {
                                ForEach(amountOfQuestions, id: \.self) { amount in
                                    Text("\(amount)")
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(.top, 9)
                            .padding(.bottom, 28)
                            .padding(.horizontal, 24)
                        }
                        .startScreenQuestionBoxStyled()

                        StartButton(startGame: startGame)

                        Spacer()
                        Spacer()
                    }
                } else {
                    VStack {
                        TotalScore(score: score)
                        Spacer()

                        Text("\(multiplicationTable) × \(questions[questionsAsked]) = ...")
                            .font(
                                .custom("Fuzzy Bubbles", size: 40)
                            )
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 20)
                        Spacer()
                        VStack{
                            GenerateAnswerButtons(correctAnswerIndex: correctAnswerIndex,
                                            tappedButton: tappedButton,
                                            questionAnswered: questionAnswered,
                                            answerChosen: answerChosen,
                                            buttonAnswers: buttonAnswers)
                        }
                        NextQuestionButton(nextQuestion: nextQuestion,
                                           questionsAsked: questionsAsked,
                                           amountOfQuestions: questionsAmountChosen,
                                           questionAnswered: questionAnswered)
                        Spacer()
                    }
                }
            }
        }
        .alert(isPresented: $alertShowing) {
            Alert(
                title: Text("Good job!"),
                message: Text("You've answered \(questionsAsked + 1) questions and you score is \(score)"),
                dismissButton: .default(Text("Restart")) {
                    restartGame()
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
