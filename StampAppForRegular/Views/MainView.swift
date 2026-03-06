//
//  MainView.swift
//  StampAppForRegular
//
//  Created by YoonieMac on 3/3/26.
//

import SwiftUI

// 메인 리스트 화면
struct MainView: View {
    
    @FetchRequest(fetchRequest: Stamp.all()) var stamps
    @EnvironmentObject var vm: StampViewModel
    let provider = StampProvider.shared
    
    @State var stampToEdit: Stamp?
    @State var isFav: Bool = false
    
//    @State var favConfig: FavConfig
//    @State var sort: Sort
//    @State var isAsc: Bool
    
    var body: some View {
        NavigationSplitView {
            // sidebar
            ZStack {
                if stamps.isEmpty {
                    NoUserView()
                } else {
                    List {
                        ForEach(stamps) { stamp in
                            NavigationLink {
                                //destination
                                UserDetailView(vm: .init(provider: provider, stamp: stamp))
                            } label: {
                                StampRowView(vm: .init(provider: provider, stamp: stamp))
                                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                        Button {
                                            // TODO: Delete Action
                                            do {
                                                try provider.delete(stamp: stamp, context: provider.viewContext)
                                            } catch {
                                                print("Error Deleting Stamp: \(error)")
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                                .background(Color.red)
                                        }
                                    }
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button {
                                            // TODO: stampToEdit에 해당 Stamp 넣기
                                            stampToEdit = stamp
                                        } label: {
                                            Label("Edit", systemImage: "pencil.and.scribble")
                                        }
                                    }
                            }
                            
                        } //:NAVIGATION LINK
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.accentColor.opacity(0.3))
                                .padding(.vertical, 5)
                        )
                    } //:LOOP
                } //:LIST
            } //:ZSTACK
            .navigationTitle("Coffee Stamp")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        //action
                        //TODO: Add Action
                        stampToEdit = Stamp.empty(context: provider.newContext)
                    } label: {
                        Image(systemName: "plus")
                            .symbolVariant(.circle)
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: favorite Action
                        
                    } label: {
                        Image(systemName: "star.fill")
                            .font(.title2)
                            .foregroundStyle(.yellow)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: Sort Action
                    } label: {
                        Image(systemName: "arrow.down")
                            .font(.title2)
                            .foregroundStyle(.mint)
                    }
                }
            }// .toolbar
            .sheet(item: $stampToEdit) {
                // dismiss
                stampToEdit = nil
            } content: { stamp in
                NavigationStack {
                    CreateUserView(vm: .init(provider: provider, stamp: stamp))
                }
            }// .sheet

        } detail: {
        } //: NavigationSplitView
    }// : body
}

#Preview {
    MainView()
}
