import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminVerifyList extends StatelessWidget {
  final supabase = Supabase.instance.client;

  Future<void> _updateStatus(String userId, String status) async {
    await supabase.from('profiles').update({'verification_state': status}).eq('id', userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("طلبات التوثيق المعلقة"), backgroundColor: Colors.redAccent),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase.from('profiles').stream(primaryKey: ['id']).eq('verification_state', 'pending'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final users = snapshot.data!;
          if (users.isEmpty) return Center(child: Text("لا توجد طلبات حالياً"));

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: EdgeInsets.all(10),
                color: Color(0xFF1A1A1A),
                child: ListTile(
                  title: Text(user['full_name'] ?? "مستخدم بدون اسم"),
                  subtitle: Text("اضغط لمراجعة الهوية"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.check, color: Colors.green), onPressed: () => _updateStatus(user['id'], 'approved')),
                      IconButton(icon: Icon(Icons.close, color: Colors.red), onPressed: () => _updateStatus(user['id'], 'rejected')),
                    ],
                  ),
                  onTap: () {
                    // هنا يمكن فتح صورة البطاقة للتأكد
                    showDialog(context: context, builder: (_) => AlertDialog(
                      content: Image.network("https://your-project.supabase.co/storage/v1/object/public/${user['identity_card_url']}"),
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
