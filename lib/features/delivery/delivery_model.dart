class DeliveryService {
  final String id, name, price, estimatedTime, description;
  final String icon;
  DeliveryService(this.id, this.name, this.price, this.estimatedTime, this.description, this.icon);
}

final List<DeliveryService> yemenDeliveryOptions = [
  DeliveryService('1', 'مزايا (Mazaya)', '١,٢٠٠ ريال', '٣٠-٤٥ دقيقة', 'الأسرع داخل الأمانة', '🚀'),
  DeliveryService('2', 'توصيل (Tawseel)', '١,٥٠٠ ريال', '١-٢ ساعة', 'تغطية شاملة لضواحي صنعاء', '📦'),
  DeliveryService('3', 'ماكس (Max Delivery)', '١,٠٠٠ ريال', '٤٠ دقيقة', 'توصيل اقتصادي وموثوق', '🛵'),
  DeliveryService('4', 'النقل الجماعي (للمحافظات)', '٤,٠٠٠ ريال', '٢٤ ساعة', 'إرسال الطلبات إلى خارج صنعاء', '🚌'),
];
