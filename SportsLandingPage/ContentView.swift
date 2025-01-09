import SwiftUI
import CoreGraphics

struct ContentView: View {
    @State var screenSize: CGSize = .zero
    @State private var animationTimer: Timer?
    @State private var selectedIndex = 0

    private let tint: Color = Color(hex: "#D4AFB9")
    
    public let images: [ImageValues] = [
        .init(
            text: "Track \n  Your \n              Progress",
            textOffset: CGSize(width: 20, height: 40),
            image: "runner",
            offsetX: -150,
            offsetY: 0,
            background: Color(hex: "##61F2C2")),
        .init(
            text: "Reach\nNew\nHeights",
            textOffset: CGSize(width: -80, height: 60),
            image: "skipping",
            offsetX: 125,
            offsetY: -100,
            background: Color(hex: "#CBEFB6")),
        .init(
            text: "Transform Your Life",
            textOffset: CGSize(width: 0, height: 0),
            image: "weights",
            offsetX: 0,
            offsetY: 160,
            background: Color(hex: "#BCF4F5"))
    ]

    
    var body: some View {
        VStack {
            ScrollViewReader { reader in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(images, id:\.self) { image in
                            VStack {
                                Spacer()
                                Text(image.text)
                                    .font(Font.custom("Anton-Regular", size: 40))
                                    .offset(image.textOffset)
                                    .textCase(.uppercase)
                                Image(image.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 400)
                                    .offset(x: image.offsetX, y: image.offsetY)
                                    .mask {
                                        Rectangle()
                                            .frame(width: .infinity, height: 730)
                                            .offset(y: -100)
                                    }
                                Spacer()
                            }
                            .id(image)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity,
                                alignment: .topLeading
                              )
                            .background(image.background)
                            .multilineTextAlignment(.center)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .overlay(geometryReader)
                .onAppear {
                    animationTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                        selectedIndex = selectedIndex + 1
                        if selectedIndex >= images.count {
                            selectedIndex = 0
                        }
                        withAnimation(.easeInOut(duration: 2)) {
                            reader.scrollTo(images[selectedIndex])
                        }
                    }
                }
            }
        }
        .overlay(alignment: .bottom) {
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    ForEach(0..<images.count, id: \.self) { i in
                        CircleToggle(id: i, selected: $selectedIndex)
                            .frame(width: 10)
                    }
                }
                
                HStack(spacing: 30) {
                    Button {
                        // Not required for demonstration
                    } label: {
                        Text("Log In")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 5)
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 20,
                                    style: .continuous
                                )
                                .stroke(tint, lineWidth: 2)
                            )
                    }
                    
                    Button {
                        // Not required for demonstration
                    } label: {
                        Text("Sign Up")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 5)
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 20,
                                    style: .continuous
                                )
                                .fill(tint)
                                .stroke(tint, lineWidth: 2)
                            )
                    }
                }
            }
            .padding(.bottom, 30)
            .font(Font.custom("Anton-Regular", size: 18))
            
        }
        .ignoresSafeArea()
    }
    
    private var geometryReader: some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    screenSize = proxy.size
                }
                .onChange(of: proxy.size) { oldValue, newValue in
                    screenSize = newValue
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
