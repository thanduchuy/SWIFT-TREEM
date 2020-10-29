//
//  InfoCellTableViewCell.swift
//  Trẻ Em
//
//  Created by Huy Than Duc on 10/9/20.
//

import UIKit

class InfoCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var btnLike: UIView!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var btnVip: UIView!
    var active = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bg.layer.cornerRadius = 10
        btnVip.roundCorners(corners: [.topLeft,.bottomRight], radius: 10)
        btnLike.layer.cornerRadius = btnLike.frame.height/2
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.btnLike.addGestureRecognizer(gesture)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc func someAction(_ sender:UITapGestureRecognizer){
        if active {
            imgLike.image = UIImage(systemName: "star.fill")
        } else {
            imgLike.image = UIImage(systemName: "star")
        }
        active.toggle()
    }
}


