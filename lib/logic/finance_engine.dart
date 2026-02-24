class FinanceEngine {
  static double calculateCommission(double price, String category) {
    if (category == "عقارات" || category == "سيارات" || category == "معدات ثقيلة") {
      return price * 0.01; // عمولة 1% للسلع الكبيرة
    } else {
      return 500.0; // عمولة ثابتة للسلع الصغيرة
    }
  }
}
