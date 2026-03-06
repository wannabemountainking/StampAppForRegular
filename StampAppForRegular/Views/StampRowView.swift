//
//  StampRowView.swift
//  StampAppForRegular
//
//  Created by YoonieMac on 3/3/26.
//

import SwiftUI
import Combine
internal import CoreData


// 리스트 셀 하나
struct StampRowView: View {
    
    @ObservedObject var stamp: Stamp
    var provider: StampProvider
    
//    @ObservedObject var vm: StampViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                Text(stamp.name)
                    .font(.title2.bold())
                Text(stamp.company)
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .topTrailing) {
            Button {
                // TODO: Favorite Action
                stamp.isFav.toggle()
                save()
            } label: {
                Image(systemName: "star")
                    .foregroundStyle(stamp.isFav ? .yellow : .gray.opacity(0.3))
                    .symbolVariant(.fill)
                    .font(.title3)
            }
            .buttonStyle(.plain)
        }
    }
    
    func save() {
//        do {
//            try vm.viewModelSave()
//        } catch {
//            print("Error Saving Core Data: \(error)")
//        }
        do {
            try provider.viewContext.save()
        } catch {
            print("Error Saving Core Data: \(error)")
        }
    }
}
//
//#Preview {
//    StampRowView(vm: .init(provider: StampProvider.shared))
//}
