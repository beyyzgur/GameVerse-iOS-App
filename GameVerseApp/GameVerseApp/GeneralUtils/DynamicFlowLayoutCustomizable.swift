//
//  DynamicFlowLayoutCustomizable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 20.01.2026.
//

import UIKit

protocol DynamicFlowLayoutCustomizable: AnyObject {
    associatedtype CustomLayout: UICollectionViewLayout
    
    var collectionView: UICollectionView! { get }
    
    func setCustomFlowLayout(lineSpacing: CGFloat?,
                             interItemSpacing: CGFloat?,
                             sectionInset: UIEdgeInsets?,
                             estimatedItemSize: CGSize?,
                             contentInset: UIEdgeInsets?)
}

extension DynamicFlowLayoutCustomizable where CustomLayout: UICollectionViewFlowLayout {
    func setCustomFlowLayout(lineSpacing: CGFloat? = nil,
                             interItemSpacing: CGFloat? = nil,
                             sectionInset: UIEdgeInsets? = nil,
                             estimatedItemSize: CGSize? = nil,
                             contentInset: UIEdgeInsets? = nil) {
        let layout = CustomLayout()
        layout.minimumLineSpacing = lineSpacing ?? 0
        layout.minimumInteritemSpacing = interItemSpacing ?? 0
        layout.sectionInset = sectionInset ?? UIEdgeInsets(top: 0,
                                                           left: 0,
                                                           bottom: 0,
                                                           right: 0)
        layout.estimatedItemSize = estimatedItemSize ?? UICollectionViewFlowLayout.automaticSize
        collectionView.contentInset = contentInset ?? .zero
        collectionView?.collectionViewLayout = layout
    }
}
