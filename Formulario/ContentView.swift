//
//  ContentView.swift
//  Formulario
//
//  Created by Marcelo Rosa on 10/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContactViewModel()
    @State var showAddContactSheet = false
    @State var selectedContact: Contact? = nil
    @State var searchText = ""
    @State var filteredContacts: [Contact] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Pesquisar Contato", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    filterContacts()
                }) {
                    Text("Pesquisar")
                        .padding()
                        .frame(width: 350, height: 35)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                List(filteredContacts.isEmpty ? viewModel.contacts : filteredContacts, id: \.id) { contact in
                    Button(action: {
                        selectedContact = contact
                        showAddContactSheet.toggle()
                    }) {
                        ContactRow(contact: contact)
                    }
                }
                .navigationTitle("Lista de Contatos")
                .navigationBarItems(trailing: Button(action: {
                    selectedContact = nil
                    showAddContactSheet.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                })
                .sheet(isPresented: $showAddContactSheet) {
                    AddContactForm(
                        contacts: $viewModel.contacts,
                        showAddContactSheet: $showAddContactSheet,
                        viewModel: viewModel,
                        selectContact: selectedContact, showCloseButton: true
                    )
                }
            }
            .onAppear {
                filteredContacts = viewModel.contacts
            }
        }
    }

    
    func filterContacts() {
        if searchText.isEmpty {
            filteredContacts = viewModel.contacts
        }
        else{
            filteredContacts = viewModel.contacts.filter { contact in
                contact.name.lowercased().contains(searchText.lowercased()) ||
                contact.phone.contains(searchText) ||
                contact.email.lowercased().contains(searchText.lowercased()) ||
                contact.cpf.contains(searchText)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
