import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prayer_times_app/Views/timer/show_time_left.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../Controller/prayer_times_controller.dart';
import '../prayer_time/prayer_time_View.dart';
import '../sun/sun_view.dart';

class PrayerTimesHome extends StatefulWidget {
  const PrayerTimesHome({Key? key}) : super(key: key);

  @override
  State<PrayerTimesHome> createState() => _PrayerTimesHomeState();
}

class _PrayerTimesHomeState extends State<PrayerTimesHome> {
  bool isStarted = false;
  int timeLeft = 0;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.delayed(Duration.zero).then((value) =>
  //       Provider.of<PrayerTimesController>(context, listen: false).loadData());
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (isStarted == false) {
     // Provider.of<PrayerTimesController>(context, listen: false).loadData();
      Timer.periodic(Duration(seconds: 1), (t) {
        var controller =
            Provider.of<PrayerTimesController>(context, listen: false);
        controller.detectPrayer();
      });
      isStarted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PrayerTimesController>(context, listen: false).loadData();
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Prayer Times",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 26)),
          subtitle: Text("Dhaka, Bangladesh",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        backgroundColor: Colors.black87,
        actions: [IconButton(onPressed: () {
          Provider.of<PrayerTimesController>(context, listen: false).loadData();
        }, icon: Icon(Icons.refresh))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: Consumer<PrayerTimesController>(
                    builder: (context, val, child) {
                  return ShowTimeLeft(
                      time: val.timeLeft,
                      timeLeft: val.timeLeft,
                      timeDistance: val.timeDistance);
                }),
              ),
              Consumer<PrayerTimesController>(builder: (context, val, child) {
                return PrayerTime(
                    prayer: "Fajr",
                    time: "${val.getPrayers.fajr} - ${val.getPrayers.sunRise}",
                    isTime: val.prayerName == "fajr" ? true : false);
              }),
              Consumer<PrayerTimesController>(builder: (context, val, child) {
                return PrayerTime(
                    prayer: "Duhar",
                    time: "${val.getPrayers.duhar} - ${val.getPrayers.asr}",
                    isTime: val.prayerName == "duhar" ? true : false);
              }),
              Consumer<PrayerTimesController>(builder: (context, val, child) {
                return PrayerTime(
                    prayer: "Asr",
                    time: "${val.getPrayers.asr} - ${val.getPrayers.maghrib}",
                    isTime: val.prayerName == "asr" ? true : false);
              }),
              Consumer<PrayerTimesController>(builder: (context, val, child) {
                return PrayerTime(
                    prayer: "Maghrib",
                    time: "${val.getPrayers.maghrib} - ${val.getPrayers.sunSet}",
                    isTime: val.prayerName == "maghrib" ? true : false);
              }),
              Consumer<PrayerTimesController>(builder: (context, val, child) {
                return PrayerTime(
                    prayer: "Esha",
                    time: "${val.getPrayers.isha} - 12:00AM",
                    isTime: val.prayerName == "isha" ? true : false);
              }),
              SizedBox(height: 10),
              Sun(),
            ],
          ),
        ),
      ),
    );
  }
}
