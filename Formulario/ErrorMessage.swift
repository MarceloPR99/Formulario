//
//  ErrorMessage.swift
//  Formulario
//
//  Created by Marcelo Rosa on 14/03/25.
//

import SwiftUI

struct ErrorMessage: View {
    var message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(.red)
            .font(.caption)
            .padding(.top, 5)
    }
}

struct ErrorMessage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessage(message: "Error Message")
    }
}
