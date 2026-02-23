import 'package:flutter/material.dart';

class WelcomeBot {
  static void showFirstTimeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.robot_2, color: Colors.amber),
            SizedBox(width: 10),
            Text("مساعد فلكس الذكي", style: TextStyle(color: Colors.white)),
          ],
        ),
        content: Text(
          "أهلاً بك في فلكس يمن! 🇾🇪\n\nأنا هنا لأضمن حقك. في هذه المنصة، زلطك ما تروح للبائع إلا لما تستلم بضاعتك وتفحصها بنفسك عبر نظام 'الضمان'.\n\nتفضل بتصفح السيارات، العقارات، والمواشي بكل أمان.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("ابدأ التصفح الآن", style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
    );
  }
}
