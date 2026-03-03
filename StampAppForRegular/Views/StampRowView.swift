//
//  StampRowView.swift
//  StampAppForRegular
//
//  Created by YoonieMac on 3/3/26.
//

import SwiftUI


// 리스트 셀 하나
struct StampRowView: View {
    
    @ObservedObject var vm: StampViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                Text(vm.stamp.name)
                    .font(.title2.bold())
                Text(vm.stamp.company)
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .topTrailing) {
            Button {
                // TODO: Favorite Action
                vm.stamp.isFav.toggle()
                save()
            } label: {
                Image(systemName: "star")
                    .foregroundStyle(vm.stamp.isFav ? .yellow : .gray.opacity(0.3))
                    .symbolVariant(.fill)
                    .font(.title3)
            }
            .buttonStyle(.plain)
        }
    }
    
    func save() {
        do {
            try vm.viewModelSave()
        } catch {
            print("Error Saving Core Data: \(error)")
        }
    }
}

#Preview {
    StampRowView(vm: .init(provider: StampProvider.shared))
}
