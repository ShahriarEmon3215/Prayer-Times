class Prayer {
  String? fajr;
  String? duhar;
  String? asr;
  String? maghrib;
  String? isha;
  String? sunSet;
  String? sunRise;

  Prayer(
      {this.fajr,
      this.duhar,
      this.asr,
      this.maghrib,
      this.isha,
      this.sunRise,
      this.sunSet});

  factory Prayer.fromJson(Map<String, dynamic> json) {
    return Prayer(
      fajr: json['fajr'],
      duhar: json['duhar'],
     asr: json['asr'],
     maghrib: json['maghrib'],
     isha: json['isha'],
     sunRise: json['sunrise'],
     sunSet: json['sunset'],
    );
  }
}
