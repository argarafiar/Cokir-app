import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import './constant/theme.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: light,
      darkTheme: dark,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
