import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'flex_yemen.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      // جدول المحفظة
      await db.execute('CREATE TABLE wallet (id INTEGER PRIMARY KEY, balance REAL, last_update TEXT)');
      // جدول الطلبات
      await db.execute('CREATE TABLE orders (id TEXT PRIMARY KEY, title TEXT, price TEXT, status TEXT, date TEXT)');
      // إدخال رصيد افتراضي لأول مرة
      await db.rawInsert('INSERT INTO wallet(balance, last_update) VALUES(750000, "2026-02-26")');
    });
  }

  // دالة لجلب الرصيد
  Future<double> getBalance() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT balance FROM wallet');
    return list.isNotEmpty ? list.first['balance'] : 0.0;
  }
}
