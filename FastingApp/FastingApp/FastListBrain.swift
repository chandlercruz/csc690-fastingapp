//
//  FastListBrain.swift
//  FastingApp
//
//  Created by student on 12/10/20.
//

import Foundation

class FastListBrain {
    
    static let listHasUpdated = Notification.Name("FastListBrain.listHasUpdated")
    static let getList = Notification.Name("FastListBrain.getList")
    
    static var FastList: [Fast] = []
    
    func addFastToList(newFastItem: Fast) {
        print("adding new fast \(newFastItem)")
        FastListBrain.FastList.append(newFastItem)
//        print(FastList)
        NotificationCenter.default.post(name: FastListBrain.listHasUpdated, object:  nil)
    }
    
    func getFastList() {
        NotificationCenter.default.post(name: FastListBrain.getList, object: nil)
    }
}
