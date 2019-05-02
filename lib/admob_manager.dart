import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

class AdmobManager {

  MobileAdTargetingInfo _targetingInfo;
  BannerAd _bannerAd;

  Future<void> init() async{
    _targetingInfo = MobileAdTargetingInfo(
      nonPersonalizedAds: true,
      testDevices: ["E46D8B061991617A79BD4B1467A65D98"]
    );
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-7839960170715319/9053940046",
      size: AdSize.banner,
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
    await FirebaseAdMob.instance.initialize(
      appId: "ca-app-pub-7839960170715319~1558593405"
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