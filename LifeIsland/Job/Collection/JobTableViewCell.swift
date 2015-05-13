//
//  JobTableViewCell.swift
//  LifeIsland
//
//  Created by Caesar on 15/5/10.
//  Copyright (c) 2015年 张世杰. All rights reserved.
//

import UIKit


class JobTableViewCell: UITableViewCell {


    @IBOutlet weak var XiangQing: UIButton!
    @IBOutlet weak var More: UIButton!
    @IBOutlet weak var DaiShou: UIButton!

    @IBOutlet weak var XiangQingView: UIView!
    @IBOutlet weak var SongDa: UIButton!
    
    @IBOutlet var addressLabel: UILabel!
//   var BiaoJi :String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        SongDa.layer.borderWidth = 1.0
        SongDa.layer.cornerRadius = 8.0
        
        DaiShou.layer.borderWidth = 1.0
        DaiShou.layer.cornerRadius = 8.0
        
        More.layer.borderWidth = 1.0
        More.layer.cornerRadius=8.0
        
        XiangQing.layer.borderWidth = 1.0
        XiangQing.layer.cornerRadius = 8.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
