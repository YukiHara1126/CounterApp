//
//  ContentView.swift
//  Counter
//
//  Created by 原裕貴 on 2021/02/05.
//

import SwiftUI

struct ContentView: View {
    @State private var isPressed: Bool = false
    @State private var number: Int  = 0

    var body: some View {
        VStack{
            Text("\(number)")
            Button(action: {
                self.isPressed.toggle()
                self.number += 1
            }, label: {
                VStack {
                    Text("Press")
                        .font(.largeTitle)
                        .fontWeight(.light)
                        
                }.neumorphic(isPressed: $isPressed, bgColor: .green)
            }).frame(maxWidth: .infinity,
                     maxHeight: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            
            Button(action: {self.number = 0}, label: {
                    Text("Reset")
            })
            .onAppear{
                guard let userdefaultnum = UserDefaults.standard.value(forKey: "number") as? Int else { return }
                self.number = userdefaultnum
            }
            .onDisappear{
                UserDefaults.standard.set(self.number, forKey: "number")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct Neumorphic: ViewModifier {
    var bgColor: Color
    @Binding var isPressed: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(
                ZStack {
                    Circle()
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: .white, radius: self.isPressed ? 7: 10, x: self.isPressed ? -5: -15, y: self.isPressed ? -5: -15)
                        .shadow(color: .black, radius: self.isPressed ? 7: 10, x: self.isPressed ? 5: 15, y: self.isPressed ? 5: 15)
                        .blendMode(.hue)
                    Circle()
                        .fill(bgColor)
                }
            )
            .scaleEffect(self.isPressed ? 0.95: 1)
            .foregroundColor(.primary)
            .animation(.spring())
    }
}

extension View {
    func neumorphic(isPressed: Binding<Bool>, bgColor: Color) -> some View {
        self.modifier(Neumorphic(bgColor: bgColor, isPressed: isPressed))
    }
}
