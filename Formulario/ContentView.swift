//
//  ContentView.swift
//  Formulario
//
//  Created by Marcelo Rosa on 10/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var name = ""
    @State var phone = ""
    @State var email = ""
    
    @State var phoneError = false
    @State var emailError = false
    @State var generalError = false
    
    @State var contacts: [(name: String, phone: String, email: String)] = []
    
    @State var showAddContactSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(contacts, id: \.phone) { contact in
                    VStack(alignment: .leading) {
                        Text(contact.name)
                            .font(.headline)
                        Text(contact.phone)
                            .font(.subheadline)
                        Text(contact.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .navigationTitle("Lista de Contato")
                .navigationBarItems(trailing: Button(action: {
                    showAddContactSheet.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                })
                .sheet(isPresented: $showAddContactSheet) {
                    AddContactView(contacts: $contacts, showAddContactSheet: $showAddContactSheet)
                }
            }
        }
    }
}

struct AddContactView: View {
    
    @Binding var contacts: [(name: String, phone: String, email: String)]
    
    @Binding var showAddContactSheet: Bool
    
    @State var name = ""
    @State var phone = ""
    @State var email = ""
    @State var phoneError = false
    @State var emailError = false
    @State var generalError = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações Pessoais")) {
                    TextField("Nome", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Telefone", text: $phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.phonePad)
                    if phoneError {
                        Text("O telefone deve conter 9 números.")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    TextField("E-mail", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                    if emailError{
                        Text("O e-mail deve conter um '@'.")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    if generalError {
                        Text("Todos os campos precisam ser preenchidos.")
                            .foregroundColor(.red)
                            .font(.caption)
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
            }
            .navigationTitle("Adicionar Contato")
        }
    }
    
    func submitForm() {
        
        phoneError = false
        emailError = false
        generalError = false
        
        if name.isEmpty || phone.isEmpty || email.isEmpty {
            generalError = true
            print("Todos os campos precisam ser preenchidos.")
        } else {
            if phone.count != 9 {
                phoneError = true
                print("Telefone Inválido.")
            }
            if !email.contains("@") {
                emailError = true
                print("E-mail Inválido.")
            }
            if !phoneError && !emailError && !generalError {
                contacts.append((name: name, phone: phone, email: email))
                
                name = ""
                phone = ""
                email = ""
                
                showAddContactSheet = false
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
