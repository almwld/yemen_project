#!/bin/bash
echo "⏳ جاري حفظ التغييرات والرفع إلى GitHub..."
git add .
git commit -m "Auto-Update: Full Navigation Integrated $(date +'%Y-%m-%d %H:%M')"
git push origin main
echo "🚀 تم الرفع بنجاح! كود ماجيك سيبدأ البناء الآن."
