//
//  ViewControllerMain.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import UIKit
import ProgressHUD

class ViewControllerMain: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var ViewResultMeal: TableViewResultSearchView!

    var searchController: UISearchController!

    lazy var modelViewMain : MainViewViewModel = {
        let viewModel = MainViewViewModel(dataSource: ViewResultMeal.dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        searchBar.delegate = self
        ViewResultMeal.delegate = self
        bindDatos()
    }
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchTextField.textColor = UIColor.white
        searchController.searchBar.becomeFirstResponder()

    }
    func bindDatos() {
        self.modelViewMain.mealsResponse.bind {  (dataModel)  in
            if ProgressHUD() != nil {
                self.ViewResultMeal.dataSource.data.value = dataModel?.meals ?? []
                self.ViewResultMeal.filteredArray.data.value = dataModel?.meals ?? []
                ProgressHUD.dismiss()
            }
        }
        self.modelViewMain.onErrorHandling = { [weak self]  error in
            if ProgressHUD() != nil {
                ProgressHUD.dismiss()
            }
           /* let alert = UIAlertController(title: "Atención", message:error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
            */
            print("\(error?.localizedDescription)")
        }
        
        self.ViewResultMeal.dataSource.data.addAndNotify(observer: self) { [weak self] in
          //  print("update dataSource!!!")
            DispatchQueue.main.async {
                self!.ViewResultMeal.reloadAllData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            let vc = segue.destination as! DetailsMealsViewController
            let selectedIndexPath = ViewResultMeal.tableViewResultSearch.indexPathForSelectedRow
            vc.dataToSet = ViewResultMeal.filteredArray.data.value[selectedIndexPath?.row ?? 0]
        }
    }
}
extension ViewControllerMain : UISearchBarDelegate ,UISearchResultsUpdating {
 //MARK:- search update delegate
    //MARK:-

   public func updateSearchResults(for searchController: UISearchController){
        let searchString = searchController.searchBar.text

        // Filter the data array and get only those countries that match the search text.
    self.ViewResultMeal.filteredArray.data.value = self.ViewResultMeal.dataSource.data.value.filter({ (meal) -> Bool in
        let mealText: NSString = meal.strMeal as NSString
            return (mealText.range(of: searchString!, options: .caseInsensitive).location) != NSNotFound
             })
    }

    //MARK:- search bar delegate
    //MARK:-

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.ViewResultMeal.shouldShowSearchResults = true
        self.ViewResultMeal.reloadAllData()
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
          // I tried this
          searchBar.resignFirstResponder()
          // and this
          searchBar.endEditing(true)
          // and finally this
        ProgressHUD.show("")
        self.modelViewMain.fertchMeals(strToSearch: searchBar.text ?? "Mexican")
          return true
      }
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      self.ViewResultMeal.shouldShowSearchResults = false
        self.ViewResultMeal.reloadAllData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.searchController.searchBar.endEditing(true)
        self.searchBar.endEditing(true)
    }
}
extension ViewControllerMain {
   func hideKeyboardWhenTappedAround() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewControllerMain.dismissKeyboard(_:)))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
   }

   @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
       view.endEditing(true)
       if let nav = self.navigationController {
           nav.view.endEditing(true)
       }
   }
}
extension ViewControllerMain : TableViewResultSearchViewDelegate {
    func didSelectElementTable(index: IndexPath) {
        print(index.row)
        self.performSegue(withIdentifier: "segueDetail", sender: self)
    }
}
