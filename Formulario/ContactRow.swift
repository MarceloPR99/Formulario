//
//  ContactRow.swift
//  Formulario
//
//  Created by Marcelo Rosa on 14/03/25.
//

import SwiftUI

struct ContactRow: View {
    var contact: (name: String, phone: String, email: String)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(contact.name)
                .font(.headline)
            Text(contact.phone)
                .font(.subheadline)
            Text(contact.email)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(contact: (name: "Marcelo Rosa", phone: "123456789", email: "marcelo@gmail.com"))
    }
}
