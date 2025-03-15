//
//  CustomTextField.swift
//  Formulario
//
//  Created by Marcelo Rosa on 14/03/25.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(title, text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(keyboardType)
            .padding(.vertical, 8)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(title: "Exemplo", text: .constant(""), keyboardType: .default)
    }
}
