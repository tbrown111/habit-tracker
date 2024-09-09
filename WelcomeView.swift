//
//  WelcomeView.swift
//  YOU
//
//  Created by Tyson James Brown on 6/18/24.
//

import SwiftUI
import Combine




struct WelcomeView: View {
    @State private var name: String = ""
    @State private var navigateToHome: Bool = false
    @State private var isTyping: Bool = true
    @State private var timer: Timer?
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    
    let names = ["Elisha", "Blake", "Montana", "Mike"]
    @State private var currentNameIndex: Int = 0
    @State private var currentIndex: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 247/255, green: 246/255, blue: 234/255)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0.0) {
                    Spacer()
                    
                    Text("WELCOME\nto \"YOU\",\n a tool to help YOU become a BETTER person :)")
                        .font(.custom("Helvetica Neue", size: 50))
                        .multilineTextAlignment(.center)
                        .tracking(2)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text("What's your name?")
                        .font(.custom("Helvetica Neue", size: 40))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                    
                    TextField("Enter name", text: $name)
                        .font(.custom("Helvetica Neue", size: 40))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear {
                            startTypingAnimation()
                        }
                        .onTapGesture {
                            stopTypingAnimation()
                        }
                    
                    Spacer()
                    
                    NavigationLink("Continue") {
                        Button(action: {
                            if !name.isEmpty {
                                HomeView(username: name)
                            }
                        }) {
                            HStack {
                                Text("CONTINUE")
                                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                    .font(.custom("Helvetica Neue", size: 40))
                                    .fontWeight(.bold)
                            }
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)) // Adjust padding to increase thickness
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
                        .disabled(name.isEmpty)
                }

                .padding(.horizontal, 15)
                .padding(.bottom, keyboardResponder.currentHeight) // Adjust the bottom padding by keyboard height
                }
            }
        }
    }
    
    private func startTypingAnimation() {
            timer?.invalidate()
            let fullName = names[currentNameIndex]
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                if isTyping {
                    if currentIndex < fullName.count {
                        let nextIndex = fullName.index(fullName.startIndex, offsetBy: currentIndex)
                        name.append(fullName[nextIndex])
                        currentIndex += 1
                    } else {
                        isTyping = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            startDeletingAnimation()
                        }
                    }
                }
            }
        }

    private func startDeletingAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if !isTyping {
                if currentIndex > 0 {
                    currentIndex -= 1
                    name.removeLast()
                } else {
                    isTyping = true
                    currentNameIndex = (currentNameIndex + 1) % names.count // Move to the next name
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        startTypingAnimation()
                    }
                }
            }
        }
    }
    
    private func stopTypingAnimation() {
            timer?.invalidate()
            timer = nil
            name = ""
            currentIndex = 0
            isTyping = true
        }
}

final class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .map { rect in
                rect.height
            }
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
            )
            .assign(to: \.currentHeight, on: self)
    }
    
    deinit {
        cancellable?.cancel()
    }
}


#Preview {
    WelcomeView()
}
