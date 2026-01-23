import 'package:flutter/material.dart';

import '../ui/home/home_page.dart';
import '../ui/splash/splash_page.dart';

import '../features/auth/presentation/code_login_page.dart';
import '../features/marketplace/presentation/services_page.dart';
import '../features/dashboard/presentation/admin_dashboard_page.dart';

import '../core/auth/user_guard.dart';
import '../core/auth/admin_guard.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (_) => const HomePage(),
  '/splash': (_) => const SplashPage(),

  // 🔑 Login with code (deer)
  '/login': (_) => const CodeLoginPage(),

  // 🛍️ Services (User / Admin)
  '/services': (_) =>
      const UserGuard(child: ServicesPage()),

  // 🛠️ Admin Dashboard
  '/admin-dashboard': (_) =>
      const AdminGuard(child: AdminDashboardPage()),
};
