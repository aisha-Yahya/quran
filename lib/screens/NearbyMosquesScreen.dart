import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'MosqueMapScreen.dart';

class NearbyMosquesScreen extends StatefulWidget {
  const NearbyMosquesScreen({super.key});

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

  // الحصول على الموقع الجغرافي الحالي
  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('يجب منح إذن الوصول إلى الموقع لاستخدام هذه الميزة'),
          ),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print(
          "📍 تم الحصول على الموقع الحالي: ${position.latitude}, ${position.longitude}");

      setState(() {
        _currentPosition = position;
      });

      await _getMosques(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("❌ خطأ في الحصول على الموقع: $e");
    }
  }

  // استعلام المساجد القريبة
  Future<void> _getMosques(double lat, double lon) async {
    final String overpassQuery = '''
      [out:json];
      node[amenity=place_of_worship](around:15000,$lat,$lon);
      out;
    ''';

    final String url =
        "https://overpass-api.de/api/interpreter?data=${Uri.encodeComponent(overpassQuery)}";

    print("🔗 رابط الاستعلام: $url");

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        print("📦 بيانات السيرفر: ${jsonEncode(data)}");

        List<Map<String, dynamic>> mosques = [];

        if (data['elements'] == null || data['elements'].isEmpty) {
          setState(() {
            _isLoading = false;
            _mosques = [];
          });
          print("❗ لا توجد مساجد في النتائج");
          return;
        }

        for (var element in data['elements']) {
          double mLat = element['lat'];
          double mLon = element['lon'];
          String name = element['tags']?['name'] ?? "مسجد غير معروف";

          double distance = _calculateDistance(lat, lon, mLat, mLon);

          mosques.add({
            "name": name,
            "lat": mLat,
            "lon": mLon,
            "distance": distance,
          });
        }

        mosques.sort((a, b) => a["distance"].compareTo(b["distance"]));

        setState(() {
          _mosques = mosques;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _mosques = [];
        });
        print("❌ فشل الاتصال بالسيرفر: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("❌ خطأ أثناء جلب المساجد: $e");
    }
  }

  // حساب المسافة بين موقعين باستخدام Haversine formula
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295; // pi / 180
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R * asin...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المساجد القريبة'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text(
                    'جاري تحميل البيانات...',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            )
          : _mosques.isEmpty
              ? Center(
                  child: Text(
                    'لا توجد مساجد قريبة',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _mosques.length,
                  itemBuilder: (context, index) {
                    final mosque = _mosques[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent.withOpacity(0.2),
                          child: Icon(Icons.mosque, color: Colors.blueAccent),
                          radius: 25,
                        ),
                        title: Text(
                          mosque["name"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                          "المسافة: ${mosque["distance"].toStringAsFixed(2)} كم",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MosqueMapScreen(mosque: mosque),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
