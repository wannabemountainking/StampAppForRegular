//
//  StampViewModel.swift
//  StampAppForRegular
//
//  Created by YoonieMac on 3/3/26.
//

import Foundation
import CoreData
import Combine


// ObservableObject ViewModel
final class StampViewModel: ObservableObject {
    
    @Published var stamp: Stamp
    @Published var isNew: Bool = false
    
    let provider: StampProvider
    var context: NSManagedObjectContext
    
    init(provider: StampProvider, stamp: Stamp? = nil) {
        
        // 주의: stamp는 context가 설정된 후에 접근이 가능하기 때문에 미리 두 개의 값을 지정해 주는 것이 좋다.
        self.provider = provider
        if let stamp, let existingStamp = provider.exist(stamp: stamp, context: provider.viewContext) {
            // stamp수정 편집용
            self.context = provider.viewContext
            self.stamp = existingStamp
            self.isNew = false
        } else {
            // 새로운 Stamp 만들기용
            self.context = provider.newContext
            self.stamp = Stamp(context: self.context)
            self.isNew = true
        }
    }
    
    // create, edit 시 저장할 때
    func viewModelSave() throws {
        if context.hasChanges {
            try context.save()
            objectWillChange.send()
        }
    }
}
