import 'package:flutter_bloc/flutter_bloc.dart';

enum AppThemeMode { light, dark }

class ThemeState {
  final AppThemeMode mode;
  const ThemeState(this.mode);
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(AppThemeMode.light));

  void toggleTheme() {
    emit(
      ThemeState(
        state.mode == AppThemeMode.light
            ? AppThemeMode.dark
            : AppThemeMode.light,
      ),
    );
  }
}
