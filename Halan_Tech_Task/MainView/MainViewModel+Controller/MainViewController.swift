//
//  ViewController.swift
//  Halan_Tech_Task
//
//  Created by mohamed ahmed on 2/20/20.
//  Copyright © 2020 Abozaid. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

  @IBOutlet weak var CategoriesTableView: UITableView!
  
  let headerHeight:CGFloat = 39.0
  let mainViewModel = MainViewModel()
  lazy var refreshControl: UIRefreshControl = {
      let refreshControl = UIRefreshControl()
      refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)),for: UIControl.Event.valueChanged)
      refreshControl.tintColor = #colorLiteral(red: 0.4649474621, green: 0.338999629, blue: 1, alpha: 1)
      return refreshControl
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    updateUIandDelegates()
  }
  
  //MARK:- UI & Delegets
  func updateUIandDelegates(){
    CategoriesTableView.register(UINib(nibName: "MainTVC", bundle: nil), forCellReuseIdentifier: "MainTVC")
    CategoriesTableView.register(UINib(nibName: "HeaderTVC", bundle: nil), forCellReuseIdentifier: "HeaderTVC")
    CategoriesTableView.addSubview(self.refreshControl)
    CategoriesTableView.delegate = self
    CategoriesTableView.dataSource = self
  }

  //MARK:- Pull To Refresh Action
  @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
      fromCach = false
      checkPermission()
  }
  
  //MARK:- Fetching Data
  override func fetchDataFromAPI(FromCach:Bool){
      refreshControl.beginRefreshing()
      mainViewModel.RefreshView(UserLat:userLocation.latitude , UserLong:userLocation.latitude ,returnCash:FromCach)
      mainViewModel.onSuccess = {[weak self] in
        guard let self = self else {return}
        self.refreshControl.endRefreshing()
        self.CategoriesTableView.reloadData()
      }
    }
  }

 //MARK:- Table Delegate & DataSource
extension MainViewController : UITableViewDelegate , UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return mainViewModel.homeData.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MainTVC", for: indexPath) as! MainTVC
    cell.ConfigureCellData(CellData: mainViewModel.homeData[indexPath.section] ,superCont:self)
    cell.delegete = self
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return ((CategoriesTableView.frame.height) - (headerHeight * 2)) / 2
  }
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableCell(withIdentifier: "HeaderTVC") as! HeaderTVC
    headerView.configureHeaders(headerInfo: mainViewModel.homeData[section])
    return headerView
  }
}

//MARK:- Service Selection Delegate
extension MainViewController: ServiceSelectionDelegate {
  func SelectedService(serviceInfo: Service) {
     let ctrl = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
     ctrl.titleStr = serviceInfo.name
     self.navigationController?.pushViewController(ctrl, animated: true)
   }
 }
