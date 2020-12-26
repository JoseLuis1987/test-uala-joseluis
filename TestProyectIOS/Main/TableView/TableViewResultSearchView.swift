//
//  TableViewResultSearchView.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import UIKit
protocol TableViewResultSearchViewDelegate {
    func didSelectElementTable(index:IndexPath)
}
class TableViewResultSearchView: UIView {
    var titleToView: UILabel = {
         let labelTitle = UILabel()
         labelTitle.font = UIFont(name: "System Semibold", size: 18)
         labelTitle.numberOfLines = 0
         labelTitle.sizeToFit()
         labelTitle.textColor = UIColor.white
         labelTitle.translatesAutoresizingMaskIntoConstraints = false
         return labelTitle
     }()
     var heightOfTableViewConstraint: NSLayoutConstraint?
   
    var dataSource :  GenericDataSource<Meal> = GenericDataSource<Meal>()
    var filteredArray: GenericDataSource<Meal> = GenericDataSource<Meal>()
    var shouldShowSearchResults = false
    var delegate: TableViewResultSearchViewDelegate?
     public var tableViewResultSearch: UITableView = {
         var tableView =  UITableView(frame: .zero)
         tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.separatorColor = UIColor.clear
         tableView.allowsSelection = true
         tableView.isScrollEnabled = true
         if #available(iOS 11.0, *) {
             tableView.separatorInsetReference = .fromAutomaticInsets
         } else {
             // Fallback on earlier versions
         }
         tableView.sectionIndexColor = .clear
         tableView.separatorStyle = .none
         tableView.separatorEffect = .none
         tableView.tableHeaderView = UIView()
         tableView.tableFooterView = UIView()
         tableView.alwaysBounceVertical = false
         tableView.bounces = false
         tableView.estimatedRowHeight = 120.0
         return tableView
         }()
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         self.commonInit()
     }
      required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         self.commonInit()
     }
     private func commonInit() {
         self.addSubview(titleToView)
         self.addSubview(tableViewResultSearch)
         tableViewResultSearch.register(UINib(nibName: "MealCell", bundle: nil), forCellReuseIdentifier: "MealCell")
         tableViewResultSearch.delegate = self
         tableViewResultSearch.dataSource = self
         titleToView.text = "Search meals "
         titleToView.topAnchor.constraint(equalTo: self.topAnchor,constant: 16).isActive = true
         titleToView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 16).isActive = true
      
         tableViewResultSearch.topAnchor.constraint(equalTo: self.titleToView.bottomAnchor,constant: 10).isActive = true
         tableViewResultSearch.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 5).isActive = true
         tableViewResultSearch.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -5).isActive = true
         tableViewResultSearch.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true
         tableViewResultSearch.separatorInset = UIEdgeInsets(top: 0, left: tableViewResultSearch.frame.width, bottom: 0, right: 0)
         self.layer.cornerRadius = 15.0
         self.layer.masksToBounds = false
         if let constraint = (self.tableViewResultSearch.constraints.filter{$0.firstAttribute == .height}.first) {
             heightOfTableViewConstraint = constraint
         }
        tableViewResultSearch.backgroundColor = UIColor.clear
        tableViewResultSearch.layer.backgroundColor = UIColor.clear.cgColor

        bindData()
     }
    func bindData() {
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
          //  print("update dataSource!s!!")
            DispatchQueue.main.async {
                self!.reloadAllData()
            }
        }
        self.filteredArray.data.addAndNotify(observer: self) { [weak self] in
            //print("update dataSource!s!!")
            DispatchQueue.main.async {
                self!.reloadAllData()
            }
        }
    }
       func reloadAllData() {
            DispatchQueue.main.async {
                self.tableViewResultSearch.reloadData()
            }
            self.layoutIfNeeded()
            self.updateConstraints()
            self.layoutIfNeeded()
            updateElementsHeigth()
        }
        
        func updateElementsHeigth() {
            self.layer.cornerRadius = 15.0
            self.layer.masksToBounds = false
            DispatchQueue.main.async {
                if let constraint = (self.constraints.filter{$0.firstAttribute == .height}.first) {
                    constraint.constant = self.tableViewResultSearch.contentSizeHeight + 90
                    self.layoutIfNeeded()
                    self.updateConstraints()
                    self.layoutIfNeeded()
                }
            }
        }

        override func didMoveToSuperview() {
            super.didMoveToSuperview()
            layoutIfNeeded()
        }
}
extension TableViewResultSearchView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.data.value.count
        }
        else {
            return dataSource.data.value.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as? MealCell  else {
            return UITableViewCell()
        }
        var dataMealMod:Meal
        if shouldShowSearchResults {
            dataMealMod = filteredArray.data.value[indexPath.row]
        }else{
            dataMealMod = dataSource.data.value[indexPath.row]
        }
        cell.dataMeal = dataMealMod
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10000, bottom: 0, right: 0)
        return cell
    }
}

extension TableViewResultSearchView : UITableViewDelegate {
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil{
            delegate?.didSelectElementTable(index: indexPath)
        }
    }
}
extension UITableView {
    var contentSizeHeight: CGFloat {
        var height = CGFloat(0)
        for section in 0..<numberOfSections {
            height = height + rectForHeader(inSection: section).height
            let rows = numberOfRows(inSection: section)
            for row in 0..<rows {
                height = height + rectForRow(at: IndexPath(row: row, section: section)).height
            }
        }
        return height
    }
}
