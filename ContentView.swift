//
//  ContentView.swift
//  SousakuKanjiQuiz
//
//  Created by 小合貴志 on 2022/06/10.
//

import Foundation
import SwiftUI

struct ContentView: View {
  let reward = RewardedAdDelegate.instance
  @State var rewardAlert = false

  var body: some View {
    Button(action: {
      rewardAlert = true
    }){
      Text("報酬獲得ボタン")
    }
    .alert(isPresented: $rewardAlert, content: {
      Alert(
        title: Text("報酬を獲得しますか？"),
        message: Text("動画を視聴すると報酬が獲得できます。"),
        primaryButton: .cancel(Text("キャンセル"),action: {
          rewardAlert = false
        }),
        secondaryButton: .default(Text("はい"),action: {
          rewardAlert = false
          reward.showRewardedAd()
      })
      )
    })
  }
}
