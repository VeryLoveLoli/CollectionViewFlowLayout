//
//  CollectionViewWaterfallsFlowLayout.swift
//  
//
//  Created by 韦烽传 on 2021/11/20.
//

import Foundation
import UIKit

/**
 瀑布流布局
 */
open class CollectionViewWaterfallsFlowLayout: UICollectionViewLayout {
    
    // MARK: Parameter
    
    /// 协议
    open weak var delegate: CollectionViewWaterfallsFlowLayoutProtocol?
    
    /// 行间隔
    open var rowSpacing: CGFloat = 0
    /// 列间隔
    open var columnSpacing: CGFloat = 0
    /// 左间隔
    open var leftSpacing: CGFloat = 0
    /// 右间隔
    open var rightSpacing: CGFloat = 0
    /// 上间隔
    open var topSpacing: CGFloat = 0
    /// 下间隔
    open var bottomSpacing: CGFloat = 0
    
    /// 每列的高度
    open var columnHeight: [CGFloat] = []
    
    
    /// 集合内容大小
    open override var collectionViewContentSize: CGSize {
        
        return CGSize.init(width: collectionView!.frame.size.width, height: columnHeight.max()! == topSpacing ? 0 : columnHeight.max()! + bottomSpacing)
    }
    
    // MARK: - Extension
    
    /**
     准备
     */
    open override func prepare() {
        super.prepare()
        
        columnHeight = [CGFloat].init(repeating: topSpacing, count: delegate?.numberOfColumn(self) ?? 2)
    }
    
    /**
     布局属性元素
     */
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        columnHeight = [CGFloat].init(repeating: topSpacing, count: delegate?.numberOfColumn(self) ?? 2)
        
        var layoutAttributesArray: [UICollectionViewLayoutAttributes] = []
        
        for section in 0..<collectionView!.numberOfSections {
            
            for row in 0..<collectionView!.numberOfItems(inSection: section) {
                
                layoutAttributesArray.append(layoutAttributesForItem(at: IndexPath.init(row: row, section: section))!)
            }
        }
        
        return layoutAttributesArray
    }
    
    /**
     布局属性计算
     */
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let layoutAttributes =  UICollectionViewLayoutAttributes.init(forCellWith:indexPath)
        
        if let height = delegate?.waterfallsFlowLayout(self, heightForItemAt: indexPath) {
            
            let column = CGFloat(delegate!.numberOfColumn(self))
            let minHeight = columnHeight.min()!
            let index = columnHeight.firstIndex(of: minHeight)!
            
            let width = (collectionView!.frame.size.width - leftSpacing - rightSpacing - columnSpacing*(column - 1))/column
            let x = leftSpacing + (width + columnSpacing)*CGFloat(index)
            let y = minHeight == topSpacing ? minHeight : minHeight + rowSpacing
            
            self.columnHeight[index] = y + height
            
            layoutAttributes.frame = CGRect.init(x: x, y: y, width: width, height: height)
            
        }
        
        return layoutAttributes
    }
    
}
