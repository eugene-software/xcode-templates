//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file is generated by custom SKELETON Xcode template.
//

import Foundation

extension NSPointerArray {
    
    func addObject(_ object: AnyObject?) {
        guard let strongObject = object else { return }

        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        addPointer(pointer)
    }

    func insertObject(_ object: AnyObject?, at index: Int) {
        guard index < count, let strongObject = object else { return }

        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        insertPointer(pointer, at: index)
    }

    func replaceObject(at index: Int, withObject object: AnyObject?) {
        guard index < count, let strongObject = object else { return }

        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        replacePointer(at: index, withPointer: pointer)
    }

    func object(at index: Int) -> AnyObject? {
        guard index < count, let pointer = self.pointer(at: index) else { return nil }
        return Unmanaged<AnyObject>.fromOpaque(pointer).takeUnretainedValue()
    }

    func removeObject(at index: Int) {
        guard index < count else { return }

        removePointer(at: index)
    }
}