//
//  infscroll.swift
//  mappy
//
//  Created by Kashif Khan on 1/24/17.
//  Copyright © 2017 Kashif Khan. All rights reserved.
//

import Foundation
import UIKit

class InfinityViewController:  UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource , UIScrollViewDelegate{
    
    var collectionView: UICollectionView!
 
    let reuseIdentifier = "InfinityScroll"
    var photosArray : [String] = []
    
    let WINDOW_WIDTH = UIScreen.main.bounds.width
    let WINDOW_HEIGHT = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
                      
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: WINDOW_WIDTH, height: WINDOW_HEIGHT), collectionViewLayout: layout)
 
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
 
        
    }
    
    
    //MARK: Private Methods
    
    func photoForIndexPath(_ indexPath: IndexPath) -> String {
        return photosArray[indexPath.row]
    }
    
    
    func reorderArray(_ photoArray:[String], startIndex:Int, endIndex:Int){
        if startIndex >= endIndex{
            return
        }
        swap(&photosArray[startIndex], &photosArray[endIndex])
        
        reorderArray(photosArray, startIndex: startIndex + 1, endIndex: endIndex - 1)
    }
    
    
    
    // UICollectionView  select delegates
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)   
    {
        print("didSelectItemAt", #line, indexPath.item)

    }
    
    
    
    // UICollectionViewDataSource delegates
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        let photoName = photoForIndexPath(indexPath)
        
        let mainImage = UIImageView(frame: CGRect(x:0,y:0,width: WINDOW_WIDTH, height:(WINDOW_WIDTH)*1.2))
        mainImage.image = UIImage(named: photoName)
        mainImage.contentMode = UIViewContentMode.scaleToFill
        
        cell.addSubview(mainImage)
        
        return cell
    }
    


    

    //    UICollectionViewDelegateFlowLayout delegates
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let size:CGSize = CGSize(width: WINDOW_WIDTH, height: (WINDOW_WIDTH)*1.203460)
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
 
    
    
    
    //UIScrollViewDelegate delegates
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let fullyScrolledContentOffset:CGFloat = self.collectionView.frame.size.width * CGFloat(photosArray.count - 1)
        if (scrollView.contentOffset.x >= fullyScrolledContentOffset)
        {
            
            // user is scrolling to the right from the last item to the 'fake' item 1.
            // reposition offset to show the 'real' item 1 at the left-hand end of the collection view
            if photosArray.count>2{
                reorderArray(photosArray, startIndex: 0, endIndex: photosArray.count - 1)
                reorderArray(photosArray, startIndex: 0, endIndex: 1)
                reorderArray(photosArray, startIndex: 2, endIndex: photosArray.count - 1)
                let indexPath : IndexPath = IndexPath(row: 1, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            }
        }
        else if (scrollView.contentOffset.x == 0)
        {
            
            if photosArray.count>2{
                reorderArray(photosArray, startIndex: 0, endIndex: photosArray.count - 1)
                reorderArray(photosArray, startIndex: 0, endIndex: photosArray.count - 3)
                reorderArray(photosArray, startIndex: photosArray.count - 2, endIndex: photosArray.count - 1)
                let indexPath : IndexPath = IndexPath(row: photosArray.count - 2, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            }
        }
    }

    
}




