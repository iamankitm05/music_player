import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdController extends GetxController {
  static const _homeScreenBannerAdUnit =
      "ca-app-pub-6431086869827222/7791996890";
  static const _playerScreenBannerAdUnit =
      "ca-app-pub-6431086869827222/3246833953";
  static const _searchScreenBannerAdUnit =
      "ca-app-pub-6431086869827222/7453586552";
  static const _settingsScreenBannerAdUnit =
      "ca-app-pub-6431086869827222/6703611667";
  static const _permissionScreenBannerAdUnit =
      "ca-app-pub-6431086869827222/9583860217";

  final homeScreenBannerAd = Rxn<BannerAd>();
  final playerScreenBannerAd = Rxn<BannerAd>();
  final searchScreenBannerAd = Rxn<BannerAd>();
  final settingsScreenBannerAd = Rxn<BannerAd>();
  final permissionScreenBannerAd = Rxn<BannerAd>();

  final homeScreenBannerAdLoaded = false.obs;
  final playerScreenBannerAdLoaded = false.obs;
  final searchScreenBannerAdLoaded = false.obs;
  final settingsScreenBannerAdLoaded = false.obs;
  final permissionScreenBannerAdLoaded = false.obs;

  late final StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    MobileAds.instance.initialize().then((value) {
      homeScreenBannerAd.value = _getBannerAd(
        adUnitId: _homeScreenBannerAdUnit,
        adState: homeScreenBannerAdLoaded,
      );
      playerScreenBannerAd.value = _getBannerAd(
        adUnitId: _playerScreenBannerAdUnit,
        adState: playerScreenBannerAdLoaded,
      );
      searchScreenBannerAd.value = _getBannerAd(
        adUnitId: _searchScreenBannerAdUnit,
        adState: searchScreenBannerAdLoaded,
      );
      settingsScreenBannerAd.value = _getBannerAd(
        adUnitId: _settingsScreenBannerAdUnit,
        adState: settingsScreenBannerAdLoaded,
      );
      permissionScreenBannerAd.value = _getBannerAd(
        adUnitId: _permissionScreenBannerAdUnit,
        adState: permissionScreenBannerAdLoaded,
      );

      Connectivity().onConnectivityChanged.listen((event) {
        if (event.contains(ConnectivityResult.mobile) ||
            event.contains(ConnectivityResult.wifi)) {
          if (!homeScreenBannerAdLoaded.value) {
            homeScreenBannerAd.value?.load();
          }
          if (!playerScreenBannerAdLoaded.value) {
            playerScreenBannerAd.value?.load();
          }
          if (!searchScreenBannerAdLoaded.value) {
            searchScreenBannerAd.value?.load();
          }
          if (!settingsScreenBannerAdLoaded.value) {
            settingsScreenBannerAd.value?.load();
          }
          if (!permissionScreenBannerAdLoaded.value) {
            permissionScreenBannerAd.value?.load();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    homeScreenBannerAd.value?.dispose();
    permissionScreenBannerAd.value?.dispose();
    searchScreenBannerAd.value?.dispose();
    settingsScreenBannerAd.value?.dispose();
    playerScreenBannerAd.value?.dispose();
    super.dispose();
  }

  BannerAd _getBannerAd({
    required String adUnitId,
    required RxBool adState,
  }) {
    return BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          adState.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          adState.value = false;
        },
      ),
      request: const AdRequest(),
    );
  }
}
