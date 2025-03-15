//
//  ContactForm.swift
//  Formulario
//
//  Created by Marcelo Rosa on 14/03/25.
//

import SwiftUI

struct AddContactForm: View {
    
    @Binding var contacts: [(name: String, phone: String, email: String)]
    @Binding var showAddContactSheet: Bool
    
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var phoneError = false
    @State private var emailError = false
    @State private var generalError = false
    
    var body: some View {
        Form {
            Section(header: Text("Informações Pessoais").font(.headline)) {
                CustomTextField(title: "Nome", text: $name)
                CustomTextField(title: "Telefone", text: $phone, keyboardType: .phonePad)
                if phoneError {
                    ErrorMessage(message: "O telefone deve conter 9 números.")
                }
                CustomTextField(title: "E-mail", text: $email, keyboardType: .emailAddress)
                if emailError {
                    ErrorMessage(message: "O e-mail deve conter um '@'.")
                }
                if generalError {
                    ErrorMessage(message: "Todos os campos precisam ser preenchidos.")
                }
            }
            
            Button(action: submitForm) {
                Text("Salvar")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
        .navigationTitle("Adicionar Contato")
        .padding()
    }
    
    func submitForm() {
        phoneError = false
        emailError = false
        generalError = false
        
        if name.isEmpty || phone.isEmpty || email.isEmpty {
            generalError = true
            return
        }
        
        if phone.count != 9 {
            phoneError = true
            return
        }
        
        if !email.contains("@") {
            emailError = true
            return
        }
    
        contacts.append((name: name, phone: phone, email: email))
        
        name = ""
        phone = ""
        email = ""
        
        showAddContactSheet = false
    }
}

struct AddContactForm_Previews: PreviewProvider {
    static var previews: some View {
        AddContactForm(contacts: .constant([]), showAddContactSheet: .constant(false))
    }
}
