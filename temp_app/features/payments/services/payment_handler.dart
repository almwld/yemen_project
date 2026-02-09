import '../../reports/services/report_service.dart';
import '../../../core/notifications/notification_service.dart';
import 'payment_log_service.dart';

class PaymentHandler {
  static void onPaymentCompleted(double price) {
    // إضافة العملية إلى السجل
    PaymentLogService.addPayment(price);

    // إضافة التقرير
    ReportService.addSale(price);

    // إشعار الإدارة
    NotificationService.notify(
      title: '💰 عملية دفع جديدة',
      message: 'تم استلام دفعة بقيمة $price ريال',
    );
  }
}
