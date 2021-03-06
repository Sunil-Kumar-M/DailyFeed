//
//  DailyFeedNewsController+Extension.swift
//  DailyFeed
//
//  Created by Sumit Paul on 03/01/17.
//

import UIKit
import Foundation
import MobileCoreServices

// MARK: - CollectionView Delegate Methods
extension DailyFeedNewsController: UICollectionViewDelegateFlowLayout {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {

            return self.newsItems.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.performBatchUpdates(nil, completion: nil)
        if let cell = collectionView.cellForItem(at: indexPath) {
            selectedCell = cell
            self.performSegue(withIdentifier: "newsDetailSegue", sender: cell)
        }

    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyFeedItemCell",
                                                          for: indexPath) as? DailyFeedItemCell
        gridCell?.configure(with: newsItems[indexPath.row], ltr: isLanguageRightToLeft)
        return gridCell!
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "newsFooterView", for: indexPath)
            
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 10)
    }
}

  // MARK: - Drag & Drop Delegate Methods

@available(iOS 11.0, *)
extension DailyFeedNewsController: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return dragItems(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return dragItems(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let dragPreviewParameters = UIDragPreviewParameters()
        if let cell = collectionView.cellForItem(at: indexPath) {
            dragPreviewParameters.backgroundColor = UIColor.white
            dragPreviewParameters.visiblePath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius)
            
        }
        return dragPreviewParameters
    }
    
    func dragItems(indexPath: IndexPath) -> [UIDragItem] {
        let cell = collectionView?.cellForItem(at: indexPath)
        cell?.clipsToBounds = true
        let draggedNewsItem = newsItems[indexPath.row]
        let itemProvider = NSItemProvider(object: draggedNewsItem)
        return [UIDragItem(itemProvider: itemProvider)]
    }
}



