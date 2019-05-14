import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

class AdmobManager {

  MobileAdTargetingInfo _targetingInfo;
  BannerAd _bannerAd;

  Future<void> init() async{
    _targetingInfo = MobileAdTargetingInfo(
      nonPersonalizedAds: true,
      testDevices: [""]
    );
    _bannerAd = BannerAd(
      adUnitId: "",
      size: AdSize.banner,
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
    await FirebaseAdMob.instance.initialize(
      appId: ""
    );
    await _bannerAd.load();
  }

  void showBanner(){
    _bannerAd.show(
      anchorType: AnchorType.top,
      anchorOffset: kToolbarHeight + 25.0,
    );
  }

  void dispose(){
    _bannerAd.dispose();
  }
}