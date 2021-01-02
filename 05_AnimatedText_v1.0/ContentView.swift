//
//  ContentView.swift
//  05_AnimatedText_v1.0
//
//  Created by emm on 02/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View {
    
    // Toggle for multicolor...
    @State var multicolor = false
    
    var body: some View {
        VStack(spacing: 25){
            TextShimmer(text: "Welcome", multiColor: $multicolor)
            TextShimmer(text: "EmmGr23", multiColor: $multicolor)
            Toggle(isOn: $multicolor, label: {
                Text("Enable Multicolor")
                .font(.title)
                    .fontWeight(.medium)
            })
        }
    }
}


//TextShimmer...

struct TextShimmer: View {
    var text: String
    @State var animation = false
    @Binding var multiColor: Bool
    
    var body: some View {
        ZStack {
            Text(text)
            .font(.system(size: 75, weight: .light))
                .foregroundColor(Color.primary.opacity(0.25))
            
            // MultiColor Text...
            
            HStack(spacing: 0){
                ForEach(0..<text.count, id: \.self){ index in
                  
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .font(.system(size: 75, weight: .light))
                        .foregroundColor(multiColor ? randomColor() : Color.primary)
                }
            }
            
            // Masking for Shimmer effect...
            .mask(
            Rectangle()
            // For some more effect we are going to use gradient...
                .fill(
                    LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.5), Color.primary, Color.primary.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
            )
                .rotationEffect(.init(degrees: 200))
                
                // Moving View Continously ...
                // so it will create shimmer effect...
                .offset(y: -250)
                .offset(y: animation ? 500 : 0)
            )
            .onAppear(perform: {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)){
                    animation.toggle()
                }
            })
        }
    }
    
    
    // Random Color...
    
    func randomColor()-> Color {
        let color = UIColor(red: 1, green: .random(in:0...1), blue: .random(in: 0...1), alpha: 1)
        return Color(color)
    }
    
}
