//
//  QuizViewController.swift
//  SousakuKanjiQuiz
//
//  Created by 小合貴志 on 2021/11/26.
//

import UIKit
import GoogleMobileAds

//var hintButtonItem: UIBarButtonItem!

class QuizViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    var bannerView: GADBannerView!
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var answerText = ""
    var correctCount = 0
    var alertController: UIAlertController!
    var selectGenre = 0
    
//    var rewardedAd: GADRewardedAd?
//    var adRequestInProgress = false
//    var testUnitId = "ca-app-pub-3940256099942544/1712485313"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                self.view.addGestureRecognizer(tapGesture)
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-8613996556603960/3357151929"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        
        answerTextField.placeholder = "答えを入力してください"
        
        csvArray = loadCSV(fileName: "quiz\(selectGenre)")
        csvArray.shuffle()
        
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        let quizImage = UIImage(named: quizArray[0])
        imageView.image = quizImage
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.sendButton.sendActions(for: .touchUpInside)
        return true
    }
 
    @objc func dismissKeyboard() {
            self.view.endEditing(true)
        }
    
    @IBAction func topButton(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hintButton(_ sender: Any) {
        RewardedAdDelegate().showRewardedAd()
        let alert = UIAlertController(title: quizArray[4], message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
        
    @IBAction func btnAction(_ sender: Any) {
        answerText = answerTextField.text!
        switch answerText {
        case quizArray[1]:
            correctCount += 1
            print("正解")
            judgeImageView.image = UIImage(named: "correct")
            
        case quizArray[2]:
            correctCount += 1
            print("正解")
            judgeImageView.image = UIImage(named: "correct")
        
        case quizArray[3]:
            correctCount += 1
            print("正解")
            judgeImageView.image = UIImage(named: "correct")
            
        default:
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
        }
        sendButton.isUserInteractionEnabled = false
        judgeImageView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.judgeImageView.isHidden = true
            self.nextQuiz()
        }
    }
    
    func nextQuiz() {
        quizCount += 1
        answerTextField.text = ""
        if quizCount < csvArray.count {
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        let quizImage = UIImage(named: quizArray[0])
        imageView.image = quizImage
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
        sendButton.isUserInteractionEnabled = true
    }
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
        let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
        let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
        csvArray = lineChange.components(separatedBy: "\n")
        csvArray.removeLast()
        } catch {
        print("エラー")
        }
        return csvArray
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: view.safeAreaLayoutGuide,
                    attribute: .bottom,
                    multiplier: 1,
                    constant: 0),
         NSLayoutConstraint(item: bannerView,
                    attribute: .centerX,
                    relatedBy: .equal,
                    toItem: view,
                    attribute: .centerX,
                    multiplier: 1,
                    constant: 0)
        ])
    }
}


    

    //    var img1 = UIImage(named:"image1")!

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
