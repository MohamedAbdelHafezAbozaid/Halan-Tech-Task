//
//  AlertVC.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/21/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {

  @IBOutlet weak var BGView: UIView!
  @IBOutlet weak var titleLbl: UILabel!
  @IBOutlet weak var disAgreeBtn: UIButton!
  @IBOutlet weak var agreeBtn: UIButton!
  
  
  
  private var superVC: UIViewController
  private var TermsString:String
  
  var onAccept:(()->Void)?
  var onDecline:(()->Void)?
  
  init (onViewController: UIViewController ,terms:String ){
    superVC = onViewController
    TermsString = terms
    super.init(nibName: "AlertVC", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.animate(withDuration: 0.3) {[weak self] in
      guard let self = self else {return}
      self.BGView.transform = .identity
      self.BGView.alpha = 1.0
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
  
  
  //MARK:- UI enhansments 
  func updateUI(){
    BGView.layer.cornerRadius = 8.0
    disAgreeBtn.layer.cornerRadius = 8.0
    agreeBtn.layer.cornerRadius = 8.0
    BGView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    BGView.alpha = 0.0
    titleLbl.text = TermsString
  }
  
  //MARK:- Adding the Controller As a Child For The SuperViewCont. Adding Constraints
  func show() {
    superVC.view.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.topAnchor.constraint(equalTo: superVC.view.topAnchor).isActive = true
    view.leftAnchor.constraint(equalTo: superVC.view.leftAnchor).isActive = true
    view.rightAnchor.constraint(equalTo: superVC.view.rightAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo: superVC.view.bottomAnchor).isActive = true
    superVC.addChild(self)
  }
  
  //MARK:- Dismissing View With Animation
  func dismiss(completion:@escaping(_ Done:Bool)->()){
      UIView.animate(withDuration: 0.3, animations: {[weak self] in
        guard let self = self else {return}
        self.view.alpha = 0
         self.BGView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.BGView.alpha = 0.0
        self.view.layoutIfNeeded()
      }) { [weak self] _ in
        guard let self = self else {return}
        completion(true)
        self.view.removeFromSuperview()
      }
  }

  @IBAction func disagreeBtnPressed(_ sender: Any) {
    onDecline?()
  }
  
  @IBAction func agreeBtnPressed(_ sender: Any) {
    onAccept?()
  }
  
   

}
