import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prayer_times_app/NoInternet/no_internet.dart';
import 'package:provider/provider.dart';
import 'Controller/prayer_times_controller.dart';
import 'Views/dashboard/dashboard.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  await Hive.initFlutter();
  await Hive.openBox('prayers');
  bool? _internet;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      _internet = true;
    }
  } on SocketException catch (_) {
    _internet = false;
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChangeNotifierProvider(
      create: (ctx) => PrayerTimesController(),
      child: _internet!? PrayerTimesHome() : NoInternetError(),
    ),
  ));
}
