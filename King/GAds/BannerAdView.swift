//
//  BannerAdView.swift
//  MyFirstApp
//
//  Created by sanjeevan on 10/06/25.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> BannerView {
        
        
        let screenWidth = UIScreen.main.bounds.width
        
        let adsize = currentOrientationInlineAdaptiveBanner(width: screenWidth)
        
        let adView = BannerView(adSize: adsize)
        
        adView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        adView.load(Request())
        
        return adView
    }

    func updateUIView(_ uiView: BannerView, context: Context) {}
}
    
