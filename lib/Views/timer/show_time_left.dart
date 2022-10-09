import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ShowTimeLeft extends StatelessWidget {
  int? time;
  int? timeLeft;
  int? timeDistance;
  ShowTimeLeft({Key? key, this.time, this.timeLeft, this.timeDistance});

  @override
  Widget build(BuildContext context) {
    double h = 0, m = 0;
    h = this.time! / 3600;
    m = (time! % 3600) / 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularPercentIndicator(
          radius: 70.0,
          lineWidth: 20.0,
          percent:
              time != null ? ((timeLeft! / timeDistance!) * 100) / 100 : 1.0,
          animation: false,
          center: Icon(
            Icons.mosque,
            size: 50.0,
            color: Colors.black,
          ),
          backgroundColor: Color.fromARGB(255, 199, 199, 199),
          progressColor: Colors.black,
        ),
        Column(
          children: [
            Text("${h.toInt().toString()} H",
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
            Text("${m.toInt().toString()} M",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            Text("REMAINING", style: TextStyle(fontSize: 15))
          ],
        ),
      ],
    );
  }
}
