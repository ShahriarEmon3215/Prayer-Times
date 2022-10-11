import 'package:flutter/material.dart';
import 'package:prayer_times_app/Views/dashboard/dashboard.dart';

class NoInternetError extends StatelessWidget {
  const NoInternetError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => PrayerTimesHome()));
              },
              child: Icon(
                Icons.signal_wifi_connected_no_internet_4,
                size: 100,
              ),
            ),
            Text("No internet!"),
          ],
        ),
      ),
    );
  }
}
