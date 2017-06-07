//
//  AppInfoCell.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 4..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import UIKit

final class AppInfoCell: UITableViewCell, ListCellViewType, ListCellViewTypeContainerType{
    
    @IBOutlet weak var myImageView : UIImageView?
    @IBOutlet weak var myLabel : UILabel?
    @IBOutlet weak var myRank : UILabel?

    var cellView: ListCellViewType? {
        return self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel?.text = ""
        myImageView?.image = nil
        myRank?.text = ""
    }

}
