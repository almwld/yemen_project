import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/cubits/language_cubit.dart';
import 'features/dashboard/presentation/admin_dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'سوق اليمن الشامل',
            locale: locale,
            theme: ThemeData.dark().copyWith(
              primaryColor: const Color(0xFFD32F2F),
              scaffoldBackgroundColor: const Color(0xFF0F0F0F),
            ),
            // قمنا بإزالة const لأن الكلاس قد لا يكون قسط في التعريف
            home: DashboardPage(), 
          );
        },
      ),
    );
  }
}
