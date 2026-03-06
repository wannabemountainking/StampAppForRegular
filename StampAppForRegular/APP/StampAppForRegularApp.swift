//
//  StampAppForRegularApp.swift
//  StampAppForRegular
//
//  Created by YoonieMac on 3/3/26.
//

import SwiftUI
internal import CoreData


// @main 진입점
@main
struct StampAppForRegularApp: App {
    @StateObject var vm: StampViewModel = .init(provider: StampProvider.shared)
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, StampProvider.shared.viewContext)
//                .environmentObject(vm)
        }
    }
}
