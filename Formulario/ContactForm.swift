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
    var showCloseButton: Bool
    
    @State var name = ""
    @State var phone = ""
    @State var email = ""
    @State var cpf = ""
    @State var phoneError = false
    @State var emailError = false
    @State var generalError = false
    @State var cpfError = false
    @State var errorMessages = ""
    
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
                    CustomTextField(title: "CPF", text: $cpf)
                    if cpfError {
                        ErrorMessage(message: "O CPF é invalido.")
                    }
                    if generalError {
                        ErrorMessage(message: "Todos os campos precisam ser preenchidos.")
                    }
                }
                saveButton
                if showCloseButton {
                    closeButton
                }
            }
            .navigationTitle(selectContact == nil ? "Adicionar Contato" : "Editar Contato")
//            .padding()
            .onAppear {
                if let contact = selectContact {
                    name = contact.name
                    phone = contact.phone
                    email = contact.email
                    cpf = contact.cpf
                }
            }
            .navigationBarItems(trailing: !showCloseButton ? Button("Fechar") {
                showAddContactSheet = false
            } : nil)
    }
    func isValid() -> Bool {
        !name.isEmpty && !phone.isEmpty && !email.isEmpty && !cpf.isEmpty
    }
    
    @ViewBuilder
    var saveButton: some View {
        Section{
            if isValid() {
                Button(action: submitForm) {
                    Text("Salvar")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            } else {
                HStack{
                    Spacer()
                    Text("Preencha todos os campos")
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    var closeButton: some View {
        Section {
            HStack{
                Spacer()
                Button {
                    showAddContactSheet = false
                } label: {
                    Text("Fechar")
                        .bold()
                        .foregroundColor(.red)
                }
                Spacer()
            }
        }
    }
    
    func submitForm() {
        
        // substituir para error, unico, ativa em qualquer lugar, mas tem que se lembrar de desativar. colocar um print pra saber oq é ou fazer uma nova variavel chamada errorMessages e atribuir o erro a ela.
        
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
        
        cpf = formatCPF(cpf)
        
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

func formatCPF(_ cpf: String) -> String {
    let cleanedCPF = cpf.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    
    if cleanedCPF.count != 11 {
        return cpf
    }
    
    let firstPart = cleanedCPF.prefix(3)
    let secondPart = cleanedCPF.dropFirst(3).prefix(3)
    let thirdPart = cleanedCPF.dropFirst(6).prefix(3)
    let fourthPart = cleanedCPF.dropFirst(9).prefix(2)
    
    return "\(firstPart).\(secondPart).\(thirdPart)-\(fourthPart)"
}


func isValidCPF(_ cpf: String) -> Bool {
    return cpf.count == 14
}

#Preview {
    AddContactForm(
        contacts: .constant(Contact.mockArray),
        showAddContactSheet: .constant(false),
        viewModel: ContactViewModel(),
        selectContact: nil,
        showCloseButton: true
    )
}

#Preview {
    NavigationStack {
        AddContactForm(
            contacts: .constant(Contact.mockArray),
            showAddContactSheet: .constant(false),
            viewModel: ContactViewModel(),
            selectContact: nil,
            showCloseButton: false
        )
    }
}


//func validateCPF(_ cpf: String) -> Bool {
//    let cleanedCPF = cpf.filter { $0.isNumber }
//
//    // Check if the input is 11 digits
//    let regex = "^[0-9]{11}$"
//    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//    guard predicate.evaluate(with: cleanedCPF) else { return false }
//
//    // Check for blacklisted CPFs (e.g., all digits the same)
//    let invalidCPFs = [
//        "00000000000", "11111111111", "22222222222",
//        "33333333333", "44444444444", "55555555555",
//        "66666666666", "77777777777", "88888888888",
//        "99999999999"
//    ]
//    guard !invalidCPFs.contains(cleanedCPF) else { return false }
//
//    // Check the CPF checksum
//    return isValidCPFChecksum(cleanedCPF)
//}
//
//
////Mark: - Funções privadas para que validateCPF funcione de forma esperada.
//private func isValidCPFChecksum(_ cpf: String) -> Bool {
//    let numbers = cpf.compactMap { Int(String($0)) }
//    guard numbers.count == 11 else { return false }
//
//    // Calculate checksum digits
//    let dv1 = calculateCPFChecksum(for: numbers, multiplier: 10)
//    let dv2 = calculateCPFChecksum(for: numbers, multiplier: 11)
//
//    // Compare checksum digits with the input
//    return dv1 == numbers[9] && dv2 == numbers[10]
//}
//
//private func calculateCPFChecksum(for numbers: [Int], multiplier: Int) -> Int {
//    let sum = numbers.prefix(multiplier - 1).enumerated().reduce(0) { total, element in
//        total + element.element * (multiplier - element.offset)
//    }
//    let remainder = sum % 11
//    return remainder < 2 ? 0 : 11 - remainder
//}
