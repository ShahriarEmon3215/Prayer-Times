import 'package:flutter/material.dart';
import 'package:prayer_times_app/Controller/prayer_times_controller.dart';
import 'package:provider/provider.dart';

class Sun extends StatelessWidget {
  const Sun({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.black87),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.sunny, color: Colors.white, size: 40),
          ),
          SizedBox(width: 20),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SUN RISE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Consumer<PrayerTimesController>(
                      builder: (context, val, child) {
                        return Text(val.getPrayers.sunRise!,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20));
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SUN SET",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                     Consumer<PrayerTimesController>(
                      builder: (context, val, child) {
                        return Text(val.getPrayers.sunSet!,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
