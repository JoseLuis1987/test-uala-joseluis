//
//  DetailsMealsViewController.swift
//  TestProyectIOS
//
//  Created by Jose Luis on 25/12/20.
//  Copyright © 2020 Jose Luis. All rights reserved.
//

import UIKit
import ObjectMapper
import WebKit
import AVKit

class DetailsMealsViewController: UIViewController {
    @IBOutlet weak var imageMeal: UIImageView!
    @IBOutlet weak var titleMeal: UILabel!
    @IBOutlet weak var instructionsDetails: UITextView!
    @IBOutlet weak var contentViewScroll: UIScrollView!
    @IBOutlet var webView: WKWebView!

    var dataToSet = Meal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentViewScroll.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        addDataToElements(data: dataToSet )
        self.view.layoutIfNeeded()
    }
    func addDataToElements(data:Meal) {
        titleMeal.text = String(format: "%@", data.strMeal)
       
        
        let url = URL(string: data.strMealThumb )
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.imageMeal.image = UIImage(data: data!)
            }
        }
        
        var instructions = "Ingredients \n\n "

        if !data.strIngredient1.isEqualToString(find: "") && !data.strMeasure1.isEqualToString(find: "") {
            instructions += "1.-\(data.strIngredient1) \(data.strMeasure1) \n "
        }
        if !data.strIngredient2.isEqualToString(find: "") && !data.strMeasure2.contains("") {
            instructions += "2.-\(data.strIngredient2) \(data.strMeasure2)\n "
        }
        if !data.strIngredient3.isEqualToString(find: "") && !data.strMeasure3.isEqualToString(find: "") {
            instructions += "3.-\(data.strIngredient3) \(data.strMeasure3)\n "
        }
        if !data.strIngredient4.isEqualToString(find: "") && !data.strMeasure4.isEqualToString(find: "") {
            instructions += "4.-\(data.strIngredient4) \(data.strMeasure4)\n "
        }
        if !data.strIngredient5.isEqualToString(find: "") && !data.strMeasure5.isEqualToString(find: "") {
            instructions += "5.-\(data.strIngredient5) \(data.strMeasure5)\n "
        }
        if !data.strIngredient6.isEqualToString(find: "") && !data.strMeasure6.isEqualToString(find: "") {
            instructions += "6.-\(data.strIngredient6) \(data.strMeasure6)\n "
        }
        if !data.strIngredient7.isEqualToString(find: "") && !data.strMeasure7.isEqualToString(find: "") {
            instructions += "7.-\(data.strIngredient7) \(data.strMeasure7)\n "
        }
        if !data.strIngredient8.isEqualToString(find: "") && !data.strMeasure8.isEqualToString(find: "") {
            instructions += "8.-\(data.strIngredient8) \(data.strMeasure8)\n "
        }
        if !data.strIngredient9.isEqualToString(find: "") && !data.strMeasure9.isEqualToString(find: "") {
            instructions += "9.-\(data.strIngredient9) \(data.strMeasure9)\n "
        }
        if !data.strIngredient10.isEqualToString(find: "") && !data.strMeasure10.isEqualToString(find: "") {
            instructions += "10.-\(data.strIngredient10) \(data.strMeasure10)\n "
        }
        if !data.strIngredient11.isEqualToString(find: "") && !data.strMeasure11.isEqualToString(find: "") {
            instructions += "11.-\(data.strIngredient11)  \(data.strMeasure11) \n "
        }
        if !data.strIngredient12.isEqualToString(find: "") && !data.strMeasure12.isEqualToString(find: "") {
            instructions += "12.-\(data.strIngredient12) \(data.strMeasure12)\n "
        }
        if !data.strIngredient13.isEqualToString(find: "") && !data.strMeasure13.isEqualToString(find: "") {
            instructions += "13.-\(data.strIngredient13)  \(data.strMeasure13)\n "
        }
        if !data.strIngredient14.isEqualToString(find: "") && !data.strMeasure14.isEqualToString(find: "") {
            instructions += "14.-\(data.strIngredient14) \(data.strMeasure14)\n "
        }
        if !data.strIngredient15.isEqualToString(find: "") && !data.strMeasure15.isEqualToString(find: "") {
            instructions += "15.-\(data.strIngredient15) \(data.strMeasure15)\n "
        }
        if !data.strIngredient16.isEqualToString(find: "") && !data.strMeasure16.isEqualToString(find: "") {
            instructions += "16.-\(data.strIngredient16) \(data.strMeasure16)\n "
        }
        if !data.strIngredient17.isEqualToString(find: "") && !data.strMeasure17.isEqualToString(find: "") {
            instructions += "17.-\(data.strIngredient17)  \(data.strMeasure17)\n "
        }
        if !data.strIngredient18.isEqualToString(find: "") && !data.strMeasure18.isEqualToString(find: "") {
            instructions += "18.-\(data.strIngredient18)  \(data.strMeasure18)\n "
        }
        if !data.strIngredient19.isEqualToString(find: "") && !data.strMeasure19.isEqualToString(find: "") {
            instructions += "19.-\(data.strIngredient19)  \(data.strMeasure19)\n "
        }
        if !data.strIngredient20.isEqualToString(find: "") && !data.strMeasure20.isEqualToString(find: "") {
            instructions += "20.-\(data.strIngredient20)  \(data.strMeasure20)\n "
        }
        instructions += "\n\n"
        instructions += data.strInstructions
        instructionsDetails.text = instructions
        getIdVideo(ulrVideo: data.strYoutube)
    
    }
    @objc func goToVideo() {
        print("goToVideo")
    }
    
 
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    func getIdVideo(ulrVideo:String)  {
      do {
      let regex = try NSRegularExpression(pattern: "(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)", options: .caseInsensitive)
      let match = regex.firstMatch(in: ulrVideo, options: .reportProgress, range: NSMakeRange(0, ulrVideo.lengthOfBytes(using: String.Encoding.utf8)))
      let range = match?.range(at: 0)
      let youTubeID = (ulrVideo as NSString).substring(with: range!)
        genarateThumbnailFromYouTubeID(youTubeID: youTubeID)
        getThumbnailFromVideoUrl(urlString: ulrVideo)

        loadYoutube(videoID: youTubeID)
      } catch {
      print(error)
      }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            var contentRect = CGRect.zero
            for view in self.contentViewScroll.subviews {
               contentRect = contentRect.union(view.frame)
            }
            self.contentViewScroll.contentSize = contentRect.size
        }
    }
}
extension DetailsMealsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}
extension DetailsMealsViewController:UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let newSize = textView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        instructionsDetails.frame.size = CGSize(width: newSize.width, height: newSize.height)
    }
}
extension DetailsMealsViewController :UIWebViewDelegate{
    //MARK:- Play Video
    
    func loadYoutube(videoID:String) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        webView.load(URLRequest(url: youtubeURL))
    }
    
    //MARK:- Generate Thumbnail Functions
    
    func genarateThumbnailFromYouTubeID(youTubeID: String) {
        let urlString = "http://img.youtube.com/vi/\(youTubeID)/1.jpg"
        let image = try! (UIImage(withContentsOfUrl: urlString))!
    }
    
    func getThumbnailFromVideoUrl(urlString: String) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: URL(string: urlString)!)
            let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            let time = CMTimeMake(value: 1, timescale: 20)
            let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            if img != nil {
                let frameImg  = UIImage(cgImage: img!)
                DispatchQueue.main.async(execute: {
                    // assign your image to UIImageView
                })
            }
        }
    }
}
