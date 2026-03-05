//
//  CreateUserView.swift
//  StampAppForRegular
//
//  Created by YoonieMac on 3/3/26.
//

import SwiftUI


// 추가/수정 Sheet
struct CreateUserView: View {
    
    @ObservedObject var vm: StampViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            Section {
                //content
                TextField("Name*", text: $vm.stamp.name)
                    .keyboardType(.namePhonePad)
                TextField("Company*", text: $vm.stamp.company)
                    .keyboardType(.namePhonePad)
                Toggle("Favorite", isOn: $vm.stamp.isFav)
                    .toggleStyle(.switch)
            } header: {
                Text("GENERAL")
                    .foregroundStyle(.black)
            } footer: {
                Text(" * You Should fill in name & company name")
            }//:SECTION
            
            Section {
                //content
                TextField("내용을 입력하세요", text: $vm.stamp.notes, axis: .vertical)
            } header: {
                Text("NOTE")
                    .foregroundStyle(.black)
            }
        } //:LIST
        .navigationTitle(vm.isNew ? "New User" : "Update User")
        .background(Color.accentColor.opacity(0.3))
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                // cancel
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                // save
                Button("Done") {
                    validate()
                    dismiss()
                }
                .disabled(!vm.stamp.isValid)
            }
        }
    }//:body
}

extension CreateUserView {
    func validate() {
        if vm.stamp.isValid {
            do {
                try vm.viewModelSave()
            } catch {
                print("Error Validation Error: \(error)")
            }
        } else {
            print("Stamp is not Valid")
        }
    }
}

#Preview {
    CreateUserView(vm: .init(provider: StampProvider.shared))
}
