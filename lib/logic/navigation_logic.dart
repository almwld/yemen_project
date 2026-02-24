import 'package:flutter/material.dart';
import '../screens/cars_screen.dart';
import '../screens/real_estate_screen.dart';
import '../screens/general_category_screen.dart';

void handleNavigation(BuildContext context, String name, IconData icon) {
  if (name == "سيارات") {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CarsScreen()));
  } else if (name == "عقارات") {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RealEstateScreen()));
  } else {
    // أي قسم آخر (جوالات، مواشي، فضيات...) يفتح الواجهة العامة باسمه وأيقونته
    Navigator.push(context, MaterialPageRoute(builder: (context) => GeneralCategoryScreen(categoryName: name, icon: icon)));
  }
}
