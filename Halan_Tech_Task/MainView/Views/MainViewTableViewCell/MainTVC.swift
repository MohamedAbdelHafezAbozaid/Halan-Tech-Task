//
//  MainTVC.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import UIKit

protocol ServiceSelectionDelegate {
  func SelectedService(serviceInfo:Service)
}

class MainTVC: UITableViewCell {
  
  @IBOutlet weak var servicesCollection: UICollectionView!
  
  var superController:UIViewController!
  var ServiceArray = [Service](){
    didSet{
      servicesCollection.reloadData()
    }
  }
  
  var delegete:ServiceSelectionDelegate? = nil
  
    override func awakeFromNib() {
        super.awakeFromNib()
        servicesCollection.register(UINib(nibName: "MainTableCVC", bundle: nil), forCellWithReuseIdentifier: "MainTableCVC")
        servicesCollection.delegate = self
        servicesCollection.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
  
    func ConfigureCellData(CellData:MainData , superCont:UIViewController){
       ServiceArray = CellData.services!
       superController = superCont
    }
  
  
   func selectionServiceAction(selcted:Service){
      if let terms = selcted.terms {
        Utils().TermsAlert(Cont: superController, Terms: terms) {[weak self] (result) in
         guard let self = self else {return}
          if result {
           self.ProcessDelegete(selected:selcted)
         }
        }
      } else {
        self.ProcessDelegete(selected:selcted)
      }
    }
  
  func ProcessDelegete(selected:Service){
    if let del = self.delegete {
       del.SelectedService(serviceInfo: selected)
      }
     }
    }

extension MainTVC : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return ServiceArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainTableCVC", for: indexPath) as! MainTableCVC
    cell.ConfigureCell(info: ServiceArray[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (servicesCollection.frame.width - 70) / 2
    return CGSize(width: width , height: servicesCollection.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedItem = ServiceArray[indexPath.item]
    selectionServiceAction(selcted:selectedItem)
  }
}
