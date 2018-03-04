//
//  MemoTableViewCell.swift
//  ThirdMemo
//
//  Created by 이수한 on 2018. 3. 4..
//  Copyright © 2018년 이수한. All rights reserved.
//

import UIKit

class MemoTableViewCell: UITableViewCell {
    
    static let identifier = "MemoTableViewCell"

    @IBOutlet weak var memoTitleLabel: UILabel!
    @IBOutlet weak var memoContentLabel: UILabel!
    @IBOutlet weak var memoDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
