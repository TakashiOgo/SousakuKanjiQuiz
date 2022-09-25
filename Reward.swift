//
//  Reward.swift
//  SousakuKanjiQuiz
//
//  Created by 小合貴志 on 2022/06/10.
//

import Foundation
import GoogleMobileAds

class RewardedAdDelegate: NSObject, GADFullScreenContentDelegate, ObservableObject {
  static var instance = RewardedAdDelegate()
  var rewardedAd: GADRewardedAd?

  override init() {
    super.init()
    let request = GADRequest()
    // これはテストIDなので、リリース時に自分のリワード広告IDに書き換える
    GADRewardedAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1712485313",
    request: request, completionHandler: { (ad, error) in
        if error != nil {
        // print("Rewarded ad failed to load with error: \(error.localizedDescription)")
        return
      }
      self.rewardedAd = ad
      self.rewardedAd?.fullScreenContentDelegate = self
    }
  )}

  // 広告を表示して報酬を獲得する
  func showRewardedAd() {
    let root = UIApplication.shared.windows.first?.rootViewController
    if let ad = rewardedAd {
      ad.present(fromRootViewController: root!,
      userDidEarnRewardHandler: {
        print("報酬を獲得しました。")
    })} else {
      print("Ad wasn't ready")
    }
  }

  // Tells the delegate that the rewarded ad was presented.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
  }

  // Tells the delegate that the rewarded ad was dismissed.
  func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
    // 動画の視聴を途中で止めるなどで報酬を獲得できなかった時に、インスタンスを作り直す
    // インスタンスは使い捨てなので、作り直さないと再視聴できない
    RewardedAdDelegate.instance = RewardedAdDelegate()
  }

  // Tells the delegate that the rewarded ad failed to present.
  func ad(_ ad: GADFullScreenPresentingAd,
    didFailToPresentFullScreenContentWithError error: Error) {
    print("Rewarded ad failed to present with error: \(error.localizedDescription).")
  }
}
