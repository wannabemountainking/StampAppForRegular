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
            } header: {
                Text("GENERAL")
                    .foregroundStyle(.black)
            } footer: {
                Text(" * You Should fill in name & company name")
            }//:SECTION
            
            Section
        } //:LIST
        .navigationTitle(vm.isNew ? "New User" : "Update User")
        
    }//:body
}

#Preview {
    CreateUserView(vm: .init(provider: StampProvider.shared))
}
