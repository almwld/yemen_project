import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/cubits/language_cubit.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/presentation/admin_dashboard_page.dart';

void main() {
  runApp(const YemenMarketApp());
}

class YemenMarketApp extends StatelessWidget {
  const YemenMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'يمن ماركت الشامل',
            locale: locale,
            theme: AppTheme.darkTheme, // استدعاء التيم المحفوظ
            home: DashboardPage(), // استدعاء الواجهة المدمجة
          );
        },
      ),
    );
  }
}
