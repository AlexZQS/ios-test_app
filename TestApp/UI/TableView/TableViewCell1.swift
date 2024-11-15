//// 
//  TableViewCell1.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/10
//  
//
//

import UIKit

class TableViewCell1: UITableViewCell {
    
    
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mTitleView: UILabel!
    
    @IBOutlet weak var mBodyView: UILabel!
    
    @IBOutlet weak var mTimeView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
