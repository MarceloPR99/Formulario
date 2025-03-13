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

                    if emailError {
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
                    Text("Enviar")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Agenda")
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
                print("Telefone inválido.")
            }

            if !email.contains("@") {
                emailError = true
                print("E-mail inválido.")
            }

            if !phoneError && !emailError && !generalError {
                print("Nome: \(name), Telefone: \(phone), E-mail: \(email)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
