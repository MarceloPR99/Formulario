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
    @State private var selectedContact: Contact? = nil

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.contacts, id: \.id) { contact in
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
                        selectContact: selectedContact
                    )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
