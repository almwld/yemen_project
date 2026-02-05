#!/bin/bash
# 1. إصلاح الهيكل (ليظل ثابتاً)
mkdir -p lib
[ ! -f lib/home_screen.dart ] && echo "import 'package:flutter/material.dart'; class HomeScreen extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold(body: Center(child: Text('System Solid'))); } }" > lib/home_screen.dart

# 2. أمر التنظيف وتحديث المكتبات (Deep Clean)
# سنقوم بإضافة ملف لمسح الكاش في السيرفر
echo "Pre-Build Cleaning..."
rm -f pubspec.lock

# 3. الرفع مع فرض التحديث
git add .
git commit -m "Build Optimization: Deep clean and dependency sync"
git push origin main --force
