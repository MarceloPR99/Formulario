//
//  ContentView.swift
//  Formulario
//
//  Created by Marcelo Rosa on 10/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var contacts: [(name: String, phone: String, email: String)] = []
    @State var showAddContactSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(contacts, id: \.phone) { contact in
                    ContactRow(contact: contact)
                }
                .navigationTitle("Lista de Contatos")
                .navigationBarItems(trailing: Button(action: {
                    showAddContactSheet.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                })
                .sheet(isPresented: $showAddContactSheet) {
                    AddContactForm(contacts: $contacts, showAddContactSheet: $showAddContactSheet)
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
