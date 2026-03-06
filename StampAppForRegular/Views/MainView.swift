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
    @State var isFilteringByFav: Bool = false
    
    @State var favConfig: FavConfig = .init()
    @State var sort: Sort = .asc
    @State var isAsc: Bool = false
    
    var body: some View {
        NavigationSplitView {
            // sidebar
            ZStack {
                if stamps.isEmpty {
                    NoUserView()
                } else {
                    ListView(
                        stamps: stamps,
                        provider: provider,
                        stampToEdit: $stampToEdit
                    )
                }
            } //:ZSTACK
            .navigationTitle("Coffee Stamp")
            .toolbar {
                StampToolbar(
                    provider: provider,
                    stampToEdit: $stampToEdit,
                    isFilteringByFav: $isFilteringByFav,
                    favConfig: $favConfig,
                    isAsc: $isAsc,
                    sort: $sort
                )
            }// .toolbar
            .sheet(item: $stampToEdit) {
                // dismiss
                stampToEdit = nil
            } content: { stamp in
                NavigationStack {
                    CreateUserView(vm: .init(provider: provider, stamp: stamp))
                }
            }// .sheet
            .onChange(of: favConfig) { oldValue, newFav in
                stamps.nsPredicate = Stamp.favFilter(config: newFav)
            }
            .onChange(of: sort) { oldValue, newSort in
                stamps.nsSortDescriptors = Stamp.sort(order: newSort)
            }
            .onChange(of: stamps.map { $0.name + $0.company }) { _, _ in
                print("stamps changed")
            }

        } detail: {
        } //: NavigationSplitView
    }// : body
}
    
extension MainView {
    
    struct ListView: View {
        let stamps: FetchedResults<Stamp>
        let provider: StampProvider
        @Binding var stampToEdit: Stamp?
        
        var body: some View {
            List {
                ForEach(stamps) { stamp in
                    NavigationLink {
                        //destination
                        UserDetailView(vm: .init(provider: provider, stamp: stamp))
                    } label: {
                        StampRowView(stamp: stamp, provider: provider)
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
    }// : ListView
    
    struct StampToolbar: ToolbarContent {
        
        let provider: StampProvider
        @Binding var stampToEdit: Stamp?
        @Binding var isFilteringByFav: Bool
        @Binding var favConfig: FavConfig
        @Binding var isAsc: Bool
        @Binding var sort: Sort
        
        var body: some ToolbarContent {
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
//                         TODO: favorite Action
                    favConfig.filter = isFilteringByFav ? .all : .favorites
                    isFilteringByFav.toggle()

                } label: {
                    Image(systemName: isFilteringByFav ? "star.fill" : "star")
                        .font(.title2)
                        .foregroundStyle(.yellow)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: Sort Action
                    if isAsc {
                        sort = Sort.asc
                        isAsc.toggle()
                    } else {
                        sort = Sort.dec
                        isAsc.toggle()
                    }
                } label: {
                    Image(systemName: isAsc ? "arrow.up" : "arrow.down")
                        .font(.title2)
                        .foregroundStyle(.mint)
                }
            }
        }
    }
}
    

//#Preview {
//    MainView()
//}
