import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Controller/prayer_times_controller.dart';
import 'Views/dashboard/dashboard.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  await Hive.initFlutter();
  await Hive.openBox('prayers');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChangeNotifierProvider(
      create: (ctx) => PrayerTimesController(),
      child: PrayerTimesHome(),
    ),
  ));
}
