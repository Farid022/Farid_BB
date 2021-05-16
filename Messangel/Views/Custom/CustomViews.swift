//
//  CustomViews.swift
//  Messengel
//
//  Created by Saad on 4/30/21.
//

import SwiftUI

struct MyLink: View {
    var url: String
    var text: String
    var body: some View {
        Link(destination: URL(string: url)!, label: {
            Text(text).underline()
        })
    }
}

struct NextButton: View {
    var destination: AnyView
    @Binding var active: Bool
    
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 50)
            .cornerRadius(20)
            .opacity(active ? 1 : 0.5)
            .overlay(
                NavigationLink(destination: destination) {
                    Image(systemName: "chevron.right").foregroundColor(.accentColor)
                }
            )
    }
}

struct SignupProgressView: View {
    @Binding var progress: Double
    
    var body: some View {
        ProgressView(value: progress, total: 100.0)
            .progressViewStyle(LinearProgressViewStyle(tint: .white))
            .padding(.horizontal, -15)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        progress += 12.5
                    }
                }
            }
    }
}

struct CustomCorner: Shape {

    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}


struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
