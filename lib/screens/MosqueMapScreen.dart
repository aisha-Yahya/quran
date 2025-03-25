import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MosqueMapScreen extends StatelessWidget {
  final Map<String, dynamic> mosque;

  const MosqueMapScreen({super.key, required this.mosque});

  @override
  Widget build(BuildContext context) {
    double lat = double.tryParse(mosque["lat"].toString()) ?? 0.0;
    double lon = double.tryParse(mosque["lon"].toString()) ?? 0.0;

    if (lat == 0.0 || lon == 0.0) {
      return Scaffold(
        appBar: AppBar(title: Text("الموقع غير صحيح")),
        body: Center(child: Text("الموقع غير متوفر")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(mosque["name"] ?? "موقع المسجد")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _openInMaps(lat, lon, mosque["name"] ?? "مسجد");
          },
          child: Text(
            mosque["name"] ?? "اسم المسجد غير متوفر",
            style: TextStyle(
              fontSize: 24,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _openInMaps(double lat, double lon, String label) async {
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lon($label)');
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'تعذر فتح الخرائط';
    }
  }
}
