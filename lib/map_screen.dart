import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("خريطة مجانية (OSM)")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(24.7136, 46.6753), // تحديد المركز الصحيح
          initialZoom: 13.0, // تحديد الزوم الصحيح
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
