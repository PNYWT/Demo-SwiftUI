//
//  AccountView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject private var accountViewModel = AccountViewModel()
    @FocusState private var focusedTextField: FormTextField?
    
    enum FormTextField {
        case firstName, lastName, email
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First Name", text: $accountViewModel.userModel.firstName)
                        .focused($focusedTextField, equals: .firstName)
                        .onSubmit { focusedTextField = .lastName }
                        .submitLabel(.next)
                    
                    TextField("Last Name", text: $accountViewModel.userModel.lastName)
                        .focused($focusedTextField, equals: .lastName)
                        .onSubmit { focusedTextField = .email }
                        .submitLabel(.next)
                    
                    TextField("Email", text: $accountViewModel.userModel.email)
                        .focused($focusedTextField, equals: .email)
                        .onSubmit {
                            focusedTextField = nil
                        }
                        .submitLabel(.continue)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
//                    DatePicker("Birthday", selection: $accountViewModel.userModel.birthday, displayedComponents: .date)
                    DatePicker("Birthday", selection: $accountViewModel.userModel.birthday, in: Date().oneHundredTenYearsAgo...Date().eighteenYearsAgo, displayedComponents: .date)
                    
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
                        Text("Extra Napkins")
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
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Dismiss") {
                        focusedTextField = nil
                    }
                }
            }
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
