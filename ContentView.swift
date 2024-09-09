//
//  ContentView.swift
//  YOU
//
//  Created by Tyson James Brown on 6/18/24.
//

import SwiftUI

struct User {
    var name: String
    var caloriesPerDay: Int
    var exerciseDaysPerWeek: Int
    var checkInStreak: Int
} 

struct HomeView: View {
    @State private var user = User(name: "Aryaman", caloriesPerDay: 2155, exerciseDaysPerWeek: 4, checkInStreak: 17)
    var username: String
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 247/255, green: 246/255, blue: 234/255)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0.0) {
                    Text("Hi,  \(user.name)")
                        .font(.custom("Noteworthy", size: 60))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 30)
                        .padding(.bottom, 40)
                    
                    // Spacer()
                        // .padding(.top, 0)
                    
                    VStack(alignment: .leading) {
                        Text("YOU WANT TO...")
                            .font(.custom("Noteworthy", size: 32))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                            .padding(.bottom, 25)
                        
                        HStack {
                            Image(systemName: "bed.double.fill")
                                .font(.system(size: 30))
                                .padding(.leading, 36)
                            Text("Sleep 8 hours/night")
                                .font(.custom("Noteworthy", size: 28))
                                .fontWeight(.bold)
                                .padding(.leading, 10)
                        }
                        .padding(.bottom, 25)
                        
                        HStack {
                            Image(systemName: "fork.knife")
                                .font(.system(size: 30))
                                .padding(.leading, 40)
                            Text("Eat \(user.caloriesPerDay) cal./day")
                                .font(.custom("Noteworthy", size: 28))
                                .fontWeight(.bold)
                                .padding(.leading, 22)
                        }
                        .padding(.bottom, 25)
        
                        HStack {
                            Image(systemName: "figure.strengthtraining.traditional")
                                .font(.system(size: 30))
                                .padding(.leading, 37)
                            Text("Lift \(user.exerciseDaysPerWeek) days/week")
                                .font(.custom("Noteworthy", size: 28))
                                .fontWeight(.bold)
                                .padding(.leading, 12)
                        }
                        .padding(.bottom, 50)
                    }
                    //.background(Color.black.opacity(0.1))
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 4)
                    )
                    .padding(.bottom, 50)

                    
                    Button(action: {
                        // Action for check-in
                        user.checkInStreak += 1
                    }) {
                        HStack {
                            Text("TRACK HABITS")
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                .font(.custom("Marker Felt", size: 30))
                                .fontWeight(.bold)
                            Spacer()
                            Text("\(user.checkInStreak)🔥")
                                .multilineTextAlignment(.trailing)
                                .font(.custom("Marker Felt", size: 30))
                                .fontWeight(.bold)
                        }
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)) // Adjust padding to increase thickness
                        .frame(maxWidth: .infinity)
                        .padding()
                        //.foregroundColor(Color.black)
                        .foregroundColor(Color(red: 247/255, green: 246/255, blue: 234/255))
                    }
                    .background(Color.black)
                    //.background(Color.black.opacity(0.1))
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 4)
                    )
                }
                .padding(/*@START_MENU_TOKEN@*/.horizontal, 15.0/*@END_MENU_TOKEN@*/)
                .frame(maxHeight: .infinity, alignment: .top)
                
                .navigationBarItems(
                    leading: Button(action: {
                        // Action for menu
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 5)
                    },
                    trailing: Button(action: {
                        // Action for edit
                    }) {
                        Text("Edit")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 5)
                        
                    }
                )
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        HomeView(username: "Tyson")
    }
}


#Preview {
    ContentView()
}
