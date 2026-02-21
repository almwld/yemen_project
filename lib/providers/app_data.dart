import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  double _walletBalance = 0.0;
  List<Map<String, dynamic>> _myAds = [];

  double get walletBalance => _walletBalance;
  List<Map<String, dynamic>> get myAds => _myAds;

  void updateBalance(double amount) {
    _walletBalance += amount;
    notifyListeners();
  }

  void addAd(Map<String, dynamic> ad) {
    _myAds.add(ad);
    notifyListeners();
  }
}
