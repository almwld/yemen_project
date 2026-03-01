import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static Future<void> generateInvoice(Map<String, dynamic> item, String txId) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.almaraiRegular(); // خط عربي احترافي

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlign.start,
              children: [
                pw.Center(child: pw.Text("فلكس يمن - فاتورة رسمية", style: pw.TextStyle(font: font, fontSize: 25, color: PdfColors.gold))),
                pw.Divider(),
                pw.SizedBox(height: 20),
                pw.Text("رقم العملية: $txId", style: pw.TextStyle(font: font)),
                pw.Text("المنتج: ${item['title']}", style: pw.TextStyle(font: font)),
                pw.Text("السعر: ${item['price']} ريال يمني", style: pw.TextStyle(font: font)),
                pw.Text("المدينة: ${item['city']}", style: pw.TextStyle(font: font)),
                pw.SizedBox(height: 40),
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
                  child: pw.Text("تعتبر هذه الفاتورة مستنداً رسمياً لعملية الشراء عبر منصة فلكس يمن الذكية.", style: pw.TextStyle(font: font, fontSize: 12)),
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
