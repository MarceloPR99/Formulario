//
//  ContactViewMode.swift
//  Formulario
//
//  Created by Marcelo Rosa on 15/03/25.
//

import Foundation

class ContactViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
}
