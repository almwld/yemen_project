import 'package:flutter/material.dart';

class AuctionLogic {
  // دالة لزيادة المزايدة برمجياً وتحديث الحالة
  static double placeBid(double currentPrice, {double increment = 100.0}) {
    return currentPrice + increment;
  }
}
