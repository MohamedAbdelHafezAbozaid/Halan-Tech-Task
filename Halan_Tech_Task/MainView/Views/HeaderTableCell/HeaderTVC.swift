//
//  HeaderTVC.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import UIKit

class HeaderTVC: UITableViewCell {

  @IBOutlet weak var headerTitlelbl: UILabel!
  @IBOutlet weak var headerIconImg: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      self.selectionStyle = .none
    }
  
  func configureHeaders(headerInfo:MainData){
    headerTitlelbl.text = headerInfo.naming
    headerInfo.GetPicture {[weak self] (image) in
      guard let self = self else {return}
      if let _ = image {
        self.headerIconImg.image = image!
      }
    }
  }
    
}
