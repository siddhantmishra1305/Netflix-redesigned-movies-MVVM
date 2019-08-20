//
//  PagerCell.swift
//  Netflix
//
//  Created by Siddhant Mishra on 19/08/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit
import FSPagerView

class PagerCell: UITableViewCell {

    @IBOutlet weak var carousellView: FSPagerView!{
        didSet{
            self.carousellView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "PagerCell")
            self.carousellView.transformer = FSPagerViewTransformer(type: .linear)
        }
    }
    
    var cellData = [Movie](){
        didSet{
            carousellView.reloadData()
        }
    }
    
}


extension PagerCell: FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
      return cellData.count
    }

    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PagerCell", at: index)
    
        let url = (cellData[index].orignalBackgroundUrl)!
            cell.imageView?.imageFromServerURL(url, placeHolder: nil)
            cell.textLabel?.text = (cellData[index].title)!
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return cell
        
    }


}
