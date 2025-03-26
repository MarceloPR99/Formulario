//
//  ContactForm.swift
//  Formulario
//
//  Created by Marcelo Rosa on 14/03/25.
//

import SwiftUI

struct AddContactForm: View {
    @Binding var contacts: [Contact]
    @Binding var showAddContactSheet: Bool
    
    @ObservedObject var viewModel: ContactViewModel
    
    var selectContact: Contact?
    
    @State var name = ""
    @State var phone = ""
    @State var email = ""
    @State var cpf = ""
    @State var phoneError = false
    @State var emailError = false
    @State var generalError = false
    @State var cpfError = false

    var body: some View {
        NavigationView {
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
                    CustomTextField(title: "CPF", text: $cpf)
                    if cpfError {
                        ErrorMessage(message: "O CPF é invalido.")
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
            .navigationTitle(selectContact == nil ? "Adicionar Contato" : "Editar Contato")
            .padding()
            .onAppear {
                if let contact = selectContact {
                    name = contact.name
                    phone = contact.phone
                    email = contact.email
                    cpf = contact.cpf
                }
            }
            .navigationBarItems(leading: Button("Fechar") {
                showAddContactSheet = false
            })
        }
    }

    func submitForm() {
        phoneError = false
        emailError = false
        generalError = false

        if name.isEmpty || phone.isEmpty || email.isEmpty || cpf.isEmpty{
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
        
        if !isValidCPF(cpf) {
            cpfError = true
            return
        }

        let newContact = Contact(name: name, phone: phone, email: email, cpf: cpf)

        if let contact = selectContact {
            if let index = viewModel.contacts.firstIndex(where: { $0.id == contact.id }) {
                viewModel.contacts[index] = newContact
            }
        } else {
            viewModel.contacts.append(newContact)
        }

        name = ""
        phone = ""
        email = ""
        cpf = ""

        showAddContactSheet = false
    }
}

func isValidCPF(_ cpf: String) -> Bool {
    return cpf.count == 11 && !cpf.contains(" ") && !cpf.contains("-")
}

struct AddContactForm_Previews: PreviewProvider {
    static var previews: some View {
        AddContactForm(
            contacts: .constant(Contact.mockArray),
            showAddContactSheet: .constant(false),
            viewModel: ContactViewModel(),
            selectContact: nil
        )
    }
}
