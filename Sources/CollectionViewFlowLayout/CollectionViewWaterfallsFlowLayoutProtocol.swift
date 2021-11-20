//
//  CollectionViewWaterfallsFlowLayoutProtocol.swift
//  
//
//  Created by 韦烽传 on 2021/11/20.
//

import Foundation
import UIKit

/**
 瀑布流布局协议
 */
public protocol CollectionViewWaterfallsFlowLayoutProtocol: AnyObject {
    
    /**
     列数
     */
    func numberOfColumn(_ waterfallsFlowLayout: CollectionViewWaterfallsFlowLayout) -> Int
    
    /**
     格子高度
     */
    func waterfallsFlowLayout(_ waterfallsFlowLayout: CollectionViewWaterfallsFlowLayout, heightForItemAt indexPath: IndexPath) -> CGFloat
}
