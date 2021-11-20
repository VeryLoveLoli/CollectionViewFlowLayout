//
//  CollectionViewAverageIntervalFlowLayout.swift
//  
//
//  Created by 韦烽传 on 2021/11/20.
//

import Foundation
import UIKit

/**
 平均间隔流布局
 */
open class CollectionViewAverageIntervalFlowLayout: UICollectionViewFlowLayout {
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array = super.layoutAttributesForElements(in: rect)
        
        guard let list = array else { return array }
        
        /// 行列表
        var rowList: [UICollectionViewLayoutAttributes] = []
        
        /// 间距
        var spacing: CGFloat?
        
        for item in list {
            
            /// 忽略组头、组尾
            if item.representedElementKind == UICollectionView.elementKindSectionHeader || item.representedElementKind == UICollectionView.elementKindSectionFooter {
                
                continue
            }
            
            if rowList.last?.frame.origin.y == item.frame.origin.y {
                
                rowList.append(item)
            }
            else {
                
                if rowList.count > 0 {
                    
                    spacing = calculate(rowList, space: spacing)
                }
                
                rowList = []
                rowList.append(item)
            }
        }
        
        if rowList.count > 0 {
            
            _ = calculate(rowList, space: spacing)
        }
        
        rowList = []
        
        return array
    }
    
    /**
     计算
     
     - parameter    list:       行列表
     - parameter    space:      间距
     */
    func calculate(_ list: [UICollectionViewLayoutAttributes], space: CGFloat?) -> CGFloat? {
        
        if let width = collectionView?.frame.size.width {
            
            var spacing = width - sectionInset.left - sectionInset.right
            
            for item in list {
                
                spacing -= item.frame.width
            }
            
            if list.count > 1 {
                
                spacing = spacing/CGFloat((list.count-1))
            }
            
            if let s = space {
                
                spacing = s
            }
            
            var x = sectionInset.left
            
            for item in list {
                
                var frame = item.frame
                
                frame.origin.x = x
                
                item.frame = frame
                
                x += frame.width
                x += spacing
            }
            
            return spacing
        }
        
        return nil
    }
}
