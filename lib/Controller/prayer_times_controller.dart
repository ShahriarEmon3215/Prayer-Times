import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/print.dart';
import 'package:prayer_times_app/Repository/get_data.dart';
import '../Models/prayer.dart';

class PrayerTimesController with ChangeNotifier {
  String? _prayer = "";
  String? _hour, _min, _am_pm;
  int timeLeft = 0;
  int timeDistance = 0;
  bool check = false;
  Prayer? _prayers = Prayer(
    fajr: "4:13AM",
    duhar: "1:00PM",
    asr: "4:30PM",
    maghrib: "6:00PM",
    isha: "7:30PM",
    sunRise: "5:45AM",
    sunSet: "6:55PM",
  );

  Prayer get getPrayers {
    var box = Hive.box('prayers');
    String? data = box.get('fajr');

    _prayers = Prayer(
        fajr: box.get('fajr'),
        duhar: box.get('duhar'),
        asr: box.get('asr'),
        maghrib: box.get('maghrib'),
        isha: box.get('isha'),
        sunRise: box.get('sunrise'),
        sunSet: box.get('sunset'));
    return _prayers!;
  }

  int currentTimeinSec = 0;

  int? fajr;
  int? duhar;
  int? asr;
  int? maghrib;
  int? isha;
  int? sunrise;
  int? sunset;

  String get prayerName {
    return this._prayer!;
  }

  void loadData() async {
    _prayers = await getData();
    var box = Hive.box('prayers');
    box.put('fajr', _prayers!.fajr!);
    box.put('duhar', _prayers!.duhar!);
    box.put('asr', _prayers!.asr!);
    box.put('maghrib', _prayers!.maghrib!);
    box.put('isha', _prayers!.isha!);
    box.put('sunrise', _prayers!.sunRise!);
    box.put('sunset', _prayers!.sunSet!);

    print("data loaded from api ----");
  }

  int extractTimeInSec(String time) {
    _hour = "";
    _min = "";
    _am_pm = "";
    int timeInSec;

    if (time.length == 6) {
      _hour = time[0];
      _min = time[2] + time[3];
      _am_pm = time[4] + time[5];
    } else if (time.length == 7) {
      _hour = time[0] + time[1];
      _min = time[3] + time[4];
      _am_pm = time[5] + time[6];
    }

    if (_hour! == "12") {
      timeInSec = int.parse(_min!) * 60;
    } else {
      timeInSec = int.parse(_hour!) * 3600 + int.parse(_min!) * 60;
    }

    return timeInSec;
  }

  void detectPrayer() {
    currentTimeinSec =
        extractTimeInSec(DateFormat('hh:mma').format(DateTime.now()));
    var am_pm = DateFormat('a').format(DateTime.now());

    fajr = extractTimeInSec(_prayers!.fajr!);
    duhar = extractTimeInSec(_prayers!.duhar!);
    asr = extractTimeInSec(_prayers!.asr!);
    maghrib = extractTimeInSec(_prayers!.maghrib!);
    isha = extractTimeInSec(_prayers!.isha!);
    sunrise = extractTimeInSec(_prayers!.sunRise!);
    sunset = extractTimeInSec(_prayers!.sunSet!);

    if (currentTimeinSec >= fajr! &&
        currentTimeinSec < sunrise! &&
        am_pm == "AM") {
      _prayer = "fajr";
    } else if (currentTimeinSec >= duhar! &&
        currentTimeinSec < asr! &&
        am_pm == "PM") {
      _prayer = "duhar";
    } else if (currentTimeinSec >= asr! &&
        currentTimeinSec < maghrib! &&
        am_pm == "PM") {
      _prayer = "asr";
    } else if (currentTimeinSec >= maghrib! &&
        currentTimeinSec < sunset! &&
        am_pm == "PM") {
      _prayer = "maghrib";
    } else if (currentTimeinSec >= isha! &&
        currentTimeinSec <= extractTimeInSec("11:59PM") &&
        am_pm == "PM") {
      _prayer = "isha";
    } else {
      _prayer = "";
    }

    timeLeftInSec();
    notifyListeners();
  }

  void timeLeftInSec() {
    print(_prayers!.isha!);
    if (_prayer == 'fajr') {
      timeDistance = sunrise! - fajr!;
      timeLeft = sunrise! - currentTimeinSec;
    } else if (_prayer == 'duhar') {
      timeDistance = asr! - duhar!;
      timeLeft = asr! - currentTimeinSec;
    } else if (_prayer == 'asr') {
      timeDistance = maghrib! - asr!;
      timeLeft = maghrib! - currentTimeinSec;
    } else if (_prayer == 'maghrib') {
      timeDistance = sunset! - maghrib!;
      timeLeft = sunset! - currentTimeinSec;
    } else if (_prayer == 'isha') {
      timeDistance = extractTimeInSec("11:59PM") - isha!;
      timeLeft = extractTimeInSec("11:59PM") - currentTimeinSec;
    } else {
      timeLeft = 0;
    }
  }
}
