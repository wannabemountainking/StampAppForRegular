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

                if isiPhone {
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
                } else {
                    
                }
            }
        }
    }
}

#Preview {
    UserDetailView(vm: StampViewModel(provider: StampProvider.shared))
}
