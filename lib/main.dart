import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemen_market/logic/cubits/language_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(),
      child: MaterialApp(
        title: 'Yemen Market',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const Scaffold(
          body: Center(child: Text('Yemen Market - Progressing')),
        ),
      ),
    );
  }
}
