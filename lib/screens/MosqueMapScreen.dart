import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MosqueMapScreen extends StatelessWidget {
  final Map<String, dynamic> mosque;

  const MosqueMapScreen({Key? key, required this.mosque}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحويل القيم إلى double مع التأكد من وجودها
    double lat = mosque["lat"] != null
        ? double.tryParse(mosque["lat"].toString()) ?? 0.0
        : 0.0;
    double lon = mosque["lon"] != null
        ? double.tryParse(mosque["lon"].toString()) ?? 0.0
        : 0.0;

    // التحقق من وجود الموقع
    if (lat == 0.0 || lon == 0.0) {
      return Scaffold(
        appBar: AppBar(
          title: Text("الموقع غير صحيح"),
        ),
        body: Center(
          child: Text("الموقع غير متوفر"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(mosque["name"] ?? "مسجد"),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(lat, lon), // تحديد المركز
          zoom: 15.0, // مستوى التكبير
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(lat, lon), // الموقع
                builder: (ctx) => Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
