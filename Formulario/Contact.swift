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
}

extension Contact {
    static var mockArray: [Contact] {
        return [
            Contact(name: "Alice Silva", phone: "(51) 9555-5678", email: "alice@example.com"),
            Contact(name: "Bob Esponja", phone: "(51) 9555-9876", email: "bob@example.com"),
            Contact(name: "Charlie Brown", phone: "(51) 9555-4321", email: "charlie@example.com")
        ]
    }
}
