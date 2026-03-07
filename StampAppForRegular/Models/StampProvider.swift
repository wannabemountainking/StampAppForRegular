//
//  Provider.swift
//  StampAppForRegular
//
//  Created by YoonieMac on 3/3/26.
//

import Foundation
internal import CoreData


// Core Data 환경 관리 (싱글톤)
final class StampProvider {
    
    static let shared = StampProvider()
    
    private let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    var newContext: NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = container.persistentStoreCoordinator
        return context
    }
    
    private init() {
        container = NSPersistentContainer(name: "CoffeeStamp")
//        self.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { description, error in
            if let error {
                print("Error On Core Data Loading: \(error)")
            } else {
                print("Successfully Loaded Core Data: \(description)")
            }
        }
    }
    
    // 해당 Stamp가 context에 존재하는 지 확인, 있으면 반환
    func exist(stamp: Stamp, context: NSManagedObjectContext) -> Stamp? {
        try? context.existingObject(with: stamp.objectID) as? Stamp
    }
    
    // exist 확인 후 삭제, Task(priority: .background)로 나중에 실행(비동기)시켜서 삭제 완료(exist로 확인 후 지워야 하니까)
    // 1. CoreData에 데이터가 있는지, 2. 있으면 지우고 3. 다시 context를 저장한다(다시 저장은 지운 후에 해야 하므로 비동기 작업으로 수행)
    func delete(stamp: Stamp, context: NSManagedObjectContext) throws {
        if let existingStamp = exist(stamp: stamp, context: context) {
            context.delete(existingStamp)
            Task(priority: .background) {
                try await context.perform {
                    try context.save()
                }
            }
        }
    }
}

