import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdController extends GetxController {
  static const _homeScreenBannerAdUnit =
      "ca-app-pub-3940256099942544/9214589741";
  static const _playerScreenBannerAdUnit =
      "ca-app-pub-3940256099942544/9214589741";
  static const _searchScreenBannerAdUnit =
      "ca-app-pub-3940256099942544/9214589741";
  static const _settingsScreenBannerAdUnit =
      "ca-app-pub-3940256099942544/9214589741";
  static const _permissionScreenBannerAdUnit =
      "ca-app-pub-3940256099942544/9214589741";

  final homeScreenBannerAd = Rxn<BannerAd>();
  final playerScreenBannerAd = Rxn<BannerAd>();
  final searchScreenBannerAd = Rxn<BannerAd>();
  final settingsScreenBannerAd = Rxn<BannerAd>();
  final permissionScreenBannerAd = Rxn<BannerAd>();

  @override
  void onInit() {
    super.onInit();
    MobileAds.instance.initialize().then((value) {
      _loadHomeScreenBannerAd();
      _loadPlayerScreenBannerAd();
      _loadSearchScreenBannerAd();
      _loadSettingsScreenBannerAd();
      _loadPermissionScreenBannerAd();
    });
  }

  void _loadHomeScreenBannerAd() {
    homeScreenBannerAd.value = BannerAd(
      size: AdSize.banner,
      adUnitId: _homeScreenBannerAdUnit,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    )..load();
  }

  void _loadPlayerScreenBannerAd() {
    playerScreenBannerAd.value = BannerAd(
      size: AdSize.banner,
      adUnitId: _playerScreenBannerAdUnit,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    )..load();
  }

  void _loadSearchScreenBannerAd() {
    searchScreenBannerAd.value = BannerAd(
      size: AdSize.banner,
      adUnitId: _searchScreenBannerAdUnit,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    )..load();
  }

  void _loadSettingsScreenBannerAd() {
    settingsScreenBannerAd.value = BannerAd(
      size: AdSize.banner,
      adUnitId: _settingsScreenBannerAdUnit,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    )..load();
  }

  void _loadPermissionScreenBannerAd() {
    permissionScreenBannerAd.value = BannerAd(
      size: AdSize.banner,
      adUnitId: _permissionScreenBannerAdUnit,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    )..load();
  }
}
