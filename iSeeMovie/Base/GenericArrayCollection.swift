//
//  BaseCollectionView.swift
//  iSeeMovie
//
//  Created by Tais on 7/16/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import UIKit

class ValueCollectionViewCell<T>: UICollectionViewCell {
    var value: T?
}

public typealias CollectionItemSelectionHandlerType = (IndexPath) -> Void

class ArrayCollectionViewDelegateDataSource<T>:NSObject,  UICollectionViewDelegate, UICollectionViewDataSource {
    
    var array:[T] = []
    
    // MARK: - Delegate
    var collectionItemSelectionHandler: CollectionItemSelectionHandlerType?
    var collectionWillDisplayCellHandler: CollectionItemSelectionHandlerType?
    
    
    override init() {}
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseCollectionViewCell", for: indexPath) as! ValueCollectionViewCell<T>
        cell.value = array[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let handler = collectionItemSelectionHandler {
            handler(indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let handler = collectionWillDisplayCellHandler {
            handler(indexPath)
        }
    }
    
}

