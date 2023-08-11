
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_exapence_app/screens/Home/view/Home_Screen.dart';
import 'package:income_exapence_app/screens/Insert/view/Inserr_Screen.dart';
import 'package:income_exapence_app/screens/filter/view/filter_screen.dart';
import 'package:income_exapence_app/screens/read/Read_Screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: '/',
            page: () => ReadScreen(),
          ),
          GetPage(
            name: '/Income',
            page: () => const IncomeScreen(),
          ),
          GetPage(
            name: '/home',
            page: () => const HomeScreen(),
          ),
          GetPage(
            name: '/filter',
            page: () => const FilterScreen(),
          ),
        ],
      ),
    ),
  );
}
