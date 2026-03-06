//
//  UserDetailView.swift
//  StampAppForRegular
//
//  Created by YoonieMac on 3/3/26.
//

import SwiftUI


// 상세 보기 화면
struct UserDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var vm: StampViewModel
    
    var isiPhone: Bool { horizontalSizeClass == .compact }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    //content
                    Text(isiPhone ? "아이폰" : "아이패드")
                } header: {
                    Text("Device")
                }

                Section("General") {
                    LabeledContent {
                        //content
                        Text(vm.stamp.name)
                    } label: {
                        Text("Name")
                    }
                    
                    LabeledContent {
                        Text(vm.stamp.company)
                    } label: {
                        Text("Company")
                    }
                    
                    LabeledContent {
                        Text("\(vm.stamp.totalFreeCoffee)")
                    } label: {
                        Text("Total Free")
                    }
                }
                
                Section("Stamp \(vm.stamp.selectedCoffee)/7") {
                    VStack {
                        if isiPhone {
                            HStack {
                                ForEach(1..<4) { index in
                                    Image(systemName: vm.stamp.selectedCoffee >= index ? "cup.and.saucer.fill" : "cup.and.saucer")
                                        .resizable()
                                        .foregroundStyle(vm.stamp.selectedCoffee >= index ? Color.yellow : Color.gray.opacity(0.5))
                                        .frame(width: 50, height: 50)
                                        .padding(.horizontal, 27)
                                        .onTapGesture {
                                            vm.stamp.selectedCoffee = index
                                            save()
                                        }
                                } //:LOOP
                            } //:HSTACK
                            HStack {
                                ForEach(4..<8) { index in
                                    Image(systemName: vm.stamp.selectedCoffee >= index ?  "cup.and.saucer.fill" : "cup.and.saucer")
                                        .resizable()
                                        .foregroundStyle(vm.stamp.selectedCoffee >= index ? Color.yellow : Color.gray.opacity(0.5))
                                        .frame(width: 50, height: 50)
                                        .padding(.horizontal)
                                        .onTapGesture {
                                            vm.stamp.selectedCoffee = index
                                            save()
                                        }
                                } //:LOOP
                            } //:HSTACK\
                        } else {
                            HStack {
                                ForEach(1..<8) { index in
                                    Image(systemName: vm.stamp.selectedCoffee >= index ?  "cup.and.saucer.fill" : "cup.and.saucer")
                                        .resizable()
                                        .foregroundStyle(vm.stamp.selectedCoffee >= index ? Color.yellow : Color.gray.opacity(0.5))
                                        .frame(width: 50, height: 50)
                                        .padding(.horizontal, 25)
                                        .onTapGesture {
                                            vm.stamp.selectedCoffee = index
                                            save()
                                        }
                                } //:LOOP
                            } //:HSTACK
                        }//:CONDITIONAL
                        
                        HStack {
                            Spacer()
                            Image(systemName: "cup.and.saucer.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(vm.stamp.selectedCoffee >= 7 ? .yellow : Color.gray.opacity(0.5))
                                .onTapGesture {
                                    vm.stamp.totalFreeCoffee += 1
                                    vm.stamp.selectedCoffee = 0
                                    save()
                                }
                                .disabled(vm.stamp.selectedCoffee < 7)
                            Spacer()
                        } //:HSTACK
                    } //:VSTACK
                }//:SECTION
                
                Section("Notes") {
                    Text(vm.stamp.notes)
                }
            } //:LIST
            .background(Color.accentColor.opacity(0.3))
            .scrollContentBackground(.hidden)
            .navigationTitle("Test Name")
            .navigationBarTitleDisplayMode(.inline)
        } //:NAVIGATION
    }//:body
    
    func save() {
        do {
            try vm.viewModelSave()
        } catch {
            print("Error Saving UserDetailView: \(error)")
        }
    }
}

#Preview {
    UserDetailView(vm: StampViewModel(provider: StampProvider.shared))
}
