import 'package:csc4360/wrappers/ad_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:csc4360/widgets/nav_scaffold.dart';
import 'package:csc4360/wrappers/auth_wrapper.dart';
import 'package:csc4360/wrappers/navigation_wrapper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  InterstitialAd? _interstitialAd;
  bool _adReady = false;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdWrapper.interstitialAdUnitID,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (_) {
              // TODO doesn't work because the Route is being changed in the background
              print('ad dismissed');
            }
          );
          _adReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a interstitial ad: ${err.message}');
          _adReady = false;
        },
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!_adReady) _loadInterstitialAd();

    return NavigationScaffold(
      title: 'Settings',
      contents: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton(
            child: Text('Sign out'),
            onPressed: () async {

              if (_adReady) _interstitialAd!.show();

              await signOut();
              await anonymousAuth();
              ChangeRoute(context, '/settings').replaceRoot();
            },
          ),
          Text('User: ${AuthWrapper.selfUID}'),
          Text('Anon: ${AuthWrapper.anonymous}')
        ],
      ),
    );

  }
}
