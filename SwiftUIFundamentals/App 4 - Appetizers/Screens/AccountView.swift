//
//  AccountView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject private var accountViewModel = AccountViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First Name", text: $accountViewModel.userModel.firstName)
                        .keyboardType(.default)
                    TextField("Last Name", text: $accountViewModel.userModel.lastName)
                        .keyboardType(.default)
                    TextField("Email", text: $accountViewModel.userModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    DatePicker("Birthday", selection: $accountViewModel.userModel.birthday, displayedComponents: .date)
                    
                    Button {
                        print("save")
                        accountViewModel.saveChange()
                    } label: {
                        Text("Save Change")
                    }

                } header: {
                    Text("Personal Info")
                }
                
                Section {
                    Toggle(isOn: $accountViewModel.userModel.extraNapkins) {
                        Text("Extar Napkins")
                    }
                    
                    Toggle(isOn: $accountViewModel.userModel.frequentRefills) {
                        Text("Frequent Refills")
                    }
                } header: {
                    Text("Requests")
                }
                .toggleStyle(SwitchToggleStyle())
                .tint(.darkGreen)
            }
            .navigationTitle(Text("📝 Account"))
        }
        .onAppear(perform: {
            accountViewModel.retrieveUser()
        })
        .alert(item: $accountViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    AccountView()
}
