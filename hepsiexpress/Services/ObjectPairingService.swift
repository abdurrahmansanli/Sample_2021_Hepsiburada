//
//  ObjectPairingService.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 22.05.2021.
//

class ObjectPairingService {
    
    class func createAvailablePairsFrom<MutableType>(array1: [MutableType], array2: [MutableType]) -> [MutableType] {
        
        var arrayResult = [MutableType]()
        var mutableArray1 = array1
        var mutableArray2 = array2
        
        while mutableArray1.count > 0 && mutableArray2.count > 0 {
            if let item = mutableArray1.first {
                arrayResult.append(item)
                mutableArray1.removeFirst()
            }
            if let item = mutableArray2.first {
                arrayResult.append(item)
                mutableArray2.removeFirst()
            }
        }
        
        if mutableArray1.count > 0 {
            arrayResult.append(contentsOf: mutableArray1)
        }
        if mutableArray2.count > 0 {
            arrayResult.append(contentsOf: mutableArray2)
        }
        
        return arrayResult
    }
}
