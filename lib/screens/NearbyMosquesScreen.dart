import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'MosqueMapScreen.dart'; // تأكد من المسار الصحيح

class NearbyMosquesScreen extends StatefulWidget {
  @override
  _NearbyMosquesScreenState createState() => _NearbyMosquesScreenState();
}

class _NearbyMosquesScreenState extends State<NearbyMosquesScreen> {
  Position? _currentPosition;
  List<Map<String, dynamic>> _mosques = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('يجب منح إذن الوصول إلى الموقع لاستخدام هذه الميزة'))),
        
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });

      await _getMosques(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("خطأ في الحصول على الموقع: $e");
    }
  }

  Future<void> _getMosques(double lat, double lon) async {
    final String overpassQuery = '''
      [out:json];
      node[amenity=place_of_worship](around:5000,$lat,$lon);
      out;
    ''';

    final String url =
        "https://overpass-api.de/api/interpreter?data=${Uri.encodeComponent(overpassQuery)}";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Map<String, dynamic>> mosques = [];

        for (var element in data['elements']) {
          double lat = element['lat'];
          double lon = element['lon'];
          String name = element['tags']?['name'] ?? "مسجد غير معروف";

          mosques.add({
            "name": name,
            "lat": lat,
            "lon": lon,
          });
        }

        setState(() {
          _mosques = mosques;
          _isLoading = false;
        });
      } else {
        throw Exception("فشل جلب البيانات");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("خطأ في جلب المساجد: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('المساجد القريبة')),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('جاري تحميل البيانات...'),
                ],
              ),
            )
          : _mosques.isEmpty
              ? Center(child: Text('لا توجد مساجد قريبة'))
              : ListView.builder(
                  itemCount: _mosques.length,
                  itemBuilder: (context, index) {
                    final mosque = _mosques[index];
                    return ListTile(
                      title: Text(mosque["name"]),
                      subtitle: Text("اضغط لعرض الموقع على الخريطة"),
                      trailing: Icon(Icons.map, color: Colors.green),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MosqueMapScreen(mosque: mosque),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
