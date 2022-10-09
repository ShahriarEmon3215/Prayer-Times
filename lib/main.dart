
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Controller/prayer_times_controller.dart';
import 'Views/dashboard/dashboard.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChangeNotifierProvider(
      create: (ctx) => PrayerTimesController(),
      child: PrayerTimesHome(),
    ),
  ));
}

