class DeliveryService {
  final String id, name, price, estimatedTime;
  final String icon;
  DeliveryService(this.id, this.name, this.price, this.estimatedTime, this.icon);
}

final List<DeliveryService> yemenDeliveryOptions = [
  DeliveryService('1', 'توصيل سريع (داخل صنعاء)', '١,٥٠٠ ريال', '٢-٤ ساعات', '⚡'),
  DeliveryService('2', 'شركة النقل البري (للمحافظات)', '٣,٠٠٠ ريال', '١-٢ يوم', '🚚'),
  DeliveryService('3', 'مندوب خاص', '٢,٠٠٠ ريال', 'فوري', '🏍️'),
];
