//
//  MealCell.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import UIKit
class MealCell: UITableViewCell {

    @IBOutlet weak var mealThump: UIImageView!
    @IBOutlet weak var titleMeal: UILabel!
    @IBOutlet weak var categoryMeal: UILabel!
    static func cellIdentifier() -> String {
          return String(describing: self)
      }
     var indexCell : IndexPath? {
            didSet {
                guard indexCell != nil else {
                    return
                }
            }
        }
    
    var dataMeal: Meal? {
         didSet {
             guard dataMeal != nil else {
                 return
             }
            titleMeal.text = dataMeal?.strMeal
            categoryMeal.text = dataMeal?.strCategory
            let url = URL(string: dataMeal?.strMealThumb ?? "")
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.mealThump.image = UIImage(data: data!)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
