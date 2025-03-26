//
//  Contact.swift
//  Formulario
//
//  Created by Marcelo Rosa on 15/03/25.
//

import Foundation

struct Contact: Identifiable {
    var id = UUID()
    var name: String
    var phone: String
    var email: String
    var cpf: String
}

extension Contact {
    static var mockArray: [Contact] {
        return [
            Contact(name: "Alice Silva", phone: "(51) 9555-5678", email: "alice@example.com", cpf: "123.456.789-00"),
            Contact(name: "Bob Esponja", phone: "(51) 9555-9876", email: "bob@example.com", cpf: "987.654.321-00"),
            Contact(name: "Charlie Brown", phone: "(51) 9555-4321", email: "charlie@example.com", cpf: "111.222.333-00")
        ]
    }
}
