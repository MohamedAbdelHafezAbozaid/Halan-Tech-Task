//
//  MainTableCVC.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import UIKit

class MainTableCVC: UICollectionViewCell {
  
  @IBOutlet weak var serviceImg: UIImageView!
  @IBOutlet weak var serviceNameLbl: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
  
  func ConfigureCell(info:Service){
    info.GetPicture {[weak self] (image) in
      guard let self = self else {return}
      if let _ = image {
        self.serviceImg.image = image!
      }
    }
    serviceImg.layer.cornerRadius = serviceImg.frame.height / 2
    serviceImg.layer.borderWidth = 1.0
    serviceImg.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    serviceNameLbl.text = info.name
  }

}
