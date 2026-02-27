import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportService {
  static Future<void> generateSalesReport() async {
    final supabase = Supabase.instance.client;
    
    // 1. جلب بيانات المبيعات
    final List<dynamic> orders = await supabase.from('orders').select();

    // 2. إنشاء ملف Excel
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sales_Report'];

    // 3. إضافة العناوين
    sheetObject.appendRow(['رقم الطلب', 'المبلغ', 'الحالة', 'التاريخ']);

    // 4. إضافة البيانات
    for (var order in orders) {
      sheetObject.appendRow([
        order['id'],
        order['total_price'],
        order['status'],
        order['created_at']
      ]);
    }

    // 5. حفظ وتصدير الملف
    var fileBytes = excel.save();
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/flex_yemen_report.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    // 6. مشاركة الملف فوراً
    await Share.shareXFiles([XFile(file.path)], text: 'تقرير مبيعات فلكس يمن 🇾🇪');
  }
}
