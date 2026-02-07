#!/bin/bash

echo "🚀 بدأت عملية الإصلاح السحرية لمشروع Yemen Project..."

# 1. تحديث ملف pubspec.yaml لإضافة المكتبات اللازمة
echo "📝 تحديث pubspec.yaml..."
sed -i '/dev_dependencies:/a \  flutter_launcher_icons: ^0.13.1\n  flutter_native_splash: ^2.4.0' pubspec.yaml

# 2. إضافة إعدادات الأيقونة والخلفية في نهاية الملف
cat << 'EOT' >> pubspec.yaml

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon.png"
  adaptive_icon_background: "#2196F3"
  adaptive_icon_foreground: "assets/icon.png"

flutter_native_splash:
  color: "#ffffff"
  image: "assets/icon.png"
  android_12:
    color: "#ffffff"
EOT

# 3. إنشاء مجلد assets وصورة وهمية (Placeholder) إذا لم تكن موجودة
mkdir -p assets
echo "🖼️ إنشاء أيقونة افتراضية..."
# ملاحظة: سنقوم بإنشاء ملف نصي كتمويه، يفضل استبداله بصورة حقيقية لاحقاً
touch assets/icon.png 

# 4. تعديل ملفات Gradle للتوافق مع الإصدارات الجديدة
echo "⚙️ تحديث إعدادات Gradle..."
if [ -f "android/settings.gradle" ]; then
    sed -i 's/8.1.1/8.6.0/g' android/settings.gradle
    sed -i 's/1.9.20/2.1.0/g' android/settings.gradle
fi

# 5. تنظيف المشروع وجلب المكتبات
echo "🧹 تنظيف وجلب المكتبات..."
flutter clean
flutter pub get

echo "✅ اكتملت المهمة! الآن يمكنك رفع الكود إلى GitHub."
echo "💡 أمر البناء المقترح في Codemagic هو:"
echo "flutter build apk --release --no-tree-shake-icons --android-skip-build-dependency-validation"
