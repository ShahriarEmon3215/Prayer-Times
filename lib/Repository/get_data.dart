import 'dart:convert';

import '../Models/prayer.dart';
import 'package:http/http.dart' as http;

Future<Prayer>? getData() async {
    var url = Uri.parse(
        'https://prayertimes-15761-default-rtdb.firebaseio.com/prayers.json');

    var response = await http.get(url);
    var extractedData = json.decode(response.body);

    if (response.statusCode == 200) {
      print(extractedData);
      return Prayer(
        fajr: extractedData['fajr'],
        duhar: extractedData['duhar'],
        asr: extractedData['asr'],
        maghrib: extractedData['maghrib'],
        isha: extractedData['isha'],
        sunRise: extractedData['sunrise'],
        sunSet: extractedData['sunset'],
      );
    } else {
      print(response.reasonPhrase);
      throw Exception("Failed to load data!");
    }
  }

