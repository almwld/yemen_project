import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/language/language_cubit.dart';
import 'features/marketplace/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale?>(
      builder: (context, locale) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          locale: locale, // null = system
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          home: const HomePage(),
        );
      },
    );
  }
}
