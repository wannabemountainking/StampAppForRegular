//
//  Stamp.swift
//  StampAppForRegular
//
//  Created by YoonieMac on 3/3/26.
//

import Foundation
internal import CoreData

// NSManagedObject 모델 + 확장
final class Stamp: NSManagedObject, Identifiable {
    @NSManaged var name: String
    @NSManaged var company: String
    @NSManaged var isFav: Bool
    @NSManaged var notes: String
    @NSManaged var totalFreeCoffee: Int
    @NSManaged var selectedCoffee: Int
    
    var isValid: Bool {
        !name.isEmpty && !company.isEmpty
    }
}

extension Stamp {
    static func all() -> NSFetchRequest<Stamp> {
        let request = NSFetchRequest<Stamp>(entityName: "Stamp")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Stamp.name, ascending: true)]
        return request
    }
    
    // context 기본값은 viewContext
    static func empty(context: NSManagedObjectContext) -> Stamp {
        Stamp(context: context)
    }
    
    // FavConfig에 따라 NSPredicate 반환
    static func favFilter(config: FavConfig) -> NSPredicate {
        switch config.filter {
        case .all:
            return NSPredicate(value: true)
        case .favorites:
            return NSPredicate(format: "isFav == %@", NSNumber(value: true))
        }
    }
    
    // Sort enum에 따라서 NSSortDescriptor 배열 반환
    static func sort(order: Sort) -> [NSSortDescriptor] {
        [NSSortDescriptor(keyPath: \Stamp.name, ascending: order == .asc)]
    }
}

// isFav
struct FavConfig: Equatable {
    enum Filter {
        case all, favorites
    }
    var filter: Filter = .all
}

// Sort 함수
enum Sort {
    case asc, dec
}
