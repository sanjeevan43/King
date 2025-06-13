//
//  ADmanager.swift
//  MyFirstApp
//
//  Created by sanjeevan on 10/06/25.
//

import SwiftUI
import GoogleMobileAds

class ADmanager: NSObject, FullScreenContentDelegate, ObservableObject {
    @Published var interstitial: InterstitialAd?

    override init() {
        super.init()
        loadAd()
    }

    func loadAd() {
        let request = Request()
        InterstitialAd.load(
            with: "ca-app-pub-3940256099942544/4411468910",
            request: request
        ) { [weak self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad: \(error.localizedDescription)")
                return
            }
            self?.interstitial = ad
            self?.interstitial?.fullScreenContentDelegate = self
        }
    }

    func showAd(from rootViewController: UIViewController) {
        if let ad = interstitial {
            ad.present(from: rootViewController)
        } else {
            print("The ad did not load")
        }
    }

    // Optional delegate methods can be implemented here if needed
}
