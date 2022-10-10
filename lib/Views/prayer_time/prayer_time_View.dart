import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/prayer_times_controller.dart';

class PrayerTime extends StatelessWidget {
  String? prayer;
  String? time;
  bool? isTime;
  PrayerTime({
    this.prayer,
    this.time,
    this.isTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var prayerController = Provider.of<PrayerTimesController>(context);

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isTime! ? Colors.black : Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 5, color: Colors.black54, blurStyle: BlurStyle.outer)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prayer!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: isTime! ? Colors.white : Colors.black),
          ),
          Text(
            time!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: isTime! ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
