//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Frédéric Rousseau on 2020-12-10.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var playerScore = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of").foregroundColor(.white)
                    Text(countries[correctAnswer]).foregroundColor(.white).font(.largeTitle).fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number]).renderingMode(.original).clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1)).shadow(color: .black, radius: 2)
                    }
                }
                
                
                
                Spacer()
                
                Text("Your score: \(playerScore)").foregroundColor(.white).font(.largeTitle).fontWeight(.bold)
            }
        }
        
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                askQuestion()
            })
        }
    }
    
    func flagTapped(_ number : Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            playerScore += 1
            scoreMessage = "Keep it up! Already \(playerScore) good answers!"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "Wrong answer... That's the flag of \(countries[correctAnswer])"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
