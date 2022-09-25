//
//  interstitialViewController.swift
//  SousakuKanjiQuiz
//
//  Created by 小合貴志 on 2022/03/18.
//

//import UIKit
//import GoogleMobileAds
//
//class interstitialViewController: UIViewController, GADFullScreenContentDelegate {
//
//    private var interstitial: GADInterstitialAd?
//
//      override func viewDidLoad() {
//        super.viewDidLoad()
//        let request = GADRequest()
//        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
//                                    request: request,
//                          completionHandler: { [self] ad, error in
//                            if let error = error {
//                              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
//                              return
//                            }
//                            interstitial = ad
//                            interstitial?.fullScreenContentDelegate = self
//                          }
//        )
//      }
//
//    /// Tells the delegate that the ad failed to present full screen content.
//      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
//        print("Ad did fail to present full screen content.")
//      }
//
//      /// Tells the delegate that the ad will present full screen content.
//      func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("Ad will present full screen content.")
//      }
//
//      /// Tells the delegate that the ad dismissed full screen content.
//      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("Ad did dismiss full screen content.")
//      }

//    override func viewDidLoad() {
//        super.viewDidLoad()

        // Do any additional setup after loading the view.
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
