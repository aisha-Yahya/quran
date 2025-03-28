import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'MosqueMapScreen.dart'; // سنعدل هذا الملف لاحقًا

// --- استبدل بمفتاحك ---
const String googleApiKey = "AIzaSyCJsuKf6QQCpfzI8YzuInNIj4mt5NctQHA";
// ---------------------

class NearbyMosquesScreen extends StatefulWidget {
  const NearbyMosquesScreen({super.key});

  @override
  _NearbyMosquesScreenState createState() => _NearbyMosquesScreenState();
}

class _NearbyMosquesScreenState extends State<NearbyMosquesScreen> {
  Position? _currentPosition;
  List<Map<String, dynamic>> _mosques = [];
  bool _isLoading = true;
  String _errorMessage = ''; // لتخزين رسائل الخطأ

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndFetchMosques();
  }

  Future<void> _getCurrentLocationAndFetchMosques() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      // --- طلب إذن الموقع ---
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'تم رفض إذن الموقع. لا يمكن جلب المساجد.';
          });
          _showErrorSnackBar('تم رفض إذن الموقع.');
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'تم رفض إذن الموقع بشكل دائم. يرجى تمكينه من الإعدادات.';
        });
        _showErrorSnackBar('تم رفض إذن الموقع بشكل دائم.');
        // يمكنك هنا عرض حوار لتوجيه المستخدم للإعدادات
        // await Geolocator.openAppSettings();
        return;
      }

      // --- الحصول على الموقع الحالي ---
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(
          "📍 تم الحصول على الموقع الحالي: ${position.latitude}, ${position.longitude}");

      setState(() {
        _currentPosition = position;
      });

      // --- جلب المساجد باستخدام Google Places API ---
      await _getMosquesUsingGooglePlaces(position.latitude, position.longitude);
    } catch (e) {
      print("❌ خطأ في الحصول على الموقع أو جلب المساجد: $e");
      setState(() {
        _isLoading = false;
        _errorMessage = 'حدث خطأ: ${e.toString()}';
      });
      _showErrorSnackBar('حدث خطأ أثناء تحديد الموقع.');
    }
  }

  // --- دالة جلب المساجد باستخدام Google Places API ---
  Future<void> _getMosquesUsingGooglePlaces(double lat, double lon) async {
    // يمكنك تعديل نصف القطر ونوع البحث حسب الحاجة
    const double radius = 5000; // نصف القطر بالأمتار (5 كم)
    const String type = 'mosque';

    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=$lat,$lon'
        '&radius=$radius'
        '&type=$type'
        '&key=$googleApiKey'
        '&language=ar'; // طلب النتائج باللغة العربية إن أمكن

    print("🔗 رابط استعلام Google Places API: $url");

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(
            "📦 بيانات Google Places API: ${response.body}"); // طباعة الاستجابة الكاملة

        if (data['status'] == 'OK') {
          List<Map<String, dynamic>> mosques = [];
          if (data['results'] != null && data['results'] is List) {
            for (var place in data['results']) {
              // التحقق من وجود البيانات الأساسية
              if (place['geometry'] != null &&
                  place['geometry']['location'] != null &&
                  place['geometry']['location']['lat'] != null &&
                  place['geometry']['location']['lng'] != null) {
                double mLat = place['geometry']['location']['lat'];
                double mLng = place['geometry']['location']['lng'];
                String name = place['name'] ?? "مسجد غير معروف";
                String vicinity = place['vicinity'] ?? ''; // العنوان التقريبي

                // حساب المسافة (يمكن الاعتماد على Google إذا استخدمت rankby=distance)
                double distance = _calculateDistance(lat, lon, mLat, mLng);

                mosques.add({
                  "name": name,
                  "vicinity": vicinity, // إضافة العنوان التقريبي
                  "lat": mLat,
                  "lng": mLng, // خط الطول يسمى lng في Google API
                  "distance": distance,
                  "place_id":
                      place['place_id'] // معرّف المكان قد يكون مفيدًا لاحقًا
                });
              } else {
                print(
                    "⚠️ تم تخطي مكان بسبب نقص بيانات الموقع: ${place['name']}");
              }
            }
          }

          // فرز المساجد حسب المسافة
          mosques.sort((a, b) => a["distance"].compareTo(b["distance"]));

          setState(() {
            _mosques = mosques;
            _isLoading = false;
            _errorMessage = mosques.isEmpty
                ? 'لا توجد مساجد قريبة وفقًا لـ Google Maps.'
                : '';
          });
        } else {
          // معالجة حالات الخطأ من Google API
          print(
              "❌ خطأ من Google Places API: ${data['status']} - ${data['error_message'] ?? ''}");
          setState(() {
            _isLoading = false;
            _errorMessage = "فشل جلب البيانات من Google: ${data['status']}";
            _mosques = [];
          });
          _showErrorSnackBar("فشل جلب البيانات: ${data['status']}");
        }
      } else {
        // معالجة أخطاء HTTP
        print("❌ فشل الاتصال بـ Google Places API: ${response.statusCode}");
        setState(() {
          _isLoading = false;
          _errorMessage = "خطأ في الشبكة: ${response.statusCode}";
          _mosques = [];
        });
        _showErrorSnackBar("خطأ في الشبكة: ${response.statusCode}");
      }
    } catch (e) {
      // معالجة أخطاء أخرى (مثل مشاكل التحليل أو الشبكة)
      print("❌ خطأ أثناء جلب المساجد من Google Places: $e");
      setState(() {
        _isLoading = false;
        _errorMessage = 'حدث خطأ غير متوقع: ${e.toString()}';
        _mosques = [];
      });
      _showErrorSnackBar('حدث خطأ غير متوقع.');
    }
  }

  // حساب المسافة بين موقعين باستخدام Haversine formula (لا تغيير هنا)
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295; // pi / 180
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R * asin... (المسافة بالكيلومتر)
  }

  // لعرض رسالة خطأ سريعة
  void _showErrorSnackBar(String message) {
    if (mounted) {
      // التأكد من أن الويدجت ما زال في الشجرة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المساجد القريبة (Google)'),
        backgroundColor: Colors.teal, // تغيير اللون كمثال
        elevation: 0,
        actions: [
          // زر لإعادة التحميل
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _isLoading ? null : _getCurrentLocationAndFetchMosques,
            tooltip: 'تحديث الموقع والمساجد',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 15),
            Text(
              'جاري تحديد موقعك وجلب المساجد...',
              style: TextStyle(color: Colors.teal),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.redAccent, size: 50),
              SizedBox(height: 10),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.refresh),
                label: Text('حاول مرة أخرى'),
                onPressed: _getCurrentLocationAndFetchMosques,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
              )
            ],
          ),
        ),
      );
    }

    if (_mosques.isEmpty) {
      return const Center(
        child: Text(
          'لم يتم العثور على مساجد قريبة.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    // عرض قائمة المساجد
    return ListView.builder(
      itemCount: _mosques.length,
      itemBuilder: (context, index) {
        final mosque = _mosques[index];
        // التأكد من وجود خط الطول والعرض قبل استخدامهما
        final lat = mosque["lat"] as double?;
        final lng = mosque["lng"] as double?;
        final name = mosque["name"] as String?;
        final vicinity = mosque["vicinity"] as String?;
        final distance = mosque["distance"] as double?;

        if (lat == null || lng == null || name == null) {
          // عنصر فارغ أو رسالة خطأ بسيطة إذا كانت البيانات غير كاملة
          return const SizedBox.shrink();
        }

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal.withOpacity(0.15),
              child: Icon(Icons.mosque, color: Colors.teal),
              radius: 25,
            ),
            title: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (vicinity != null && vicinity.isNotEmpty)
                  Text(
                    vicinity,
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                if (distance != null)
                  Text(
                    "المسافة: ${distance.toStringAsFixed(2)} كم",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
              ],
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.teal),
            onTap: () {
              // تمرير بيانات المسجد إلى شاشة الخريطة
              // تأكد من أن MosqueMapScreen تتوقع `lng` بدلاً من `lon`
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MosqueMapScreen(mosque: mosque),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
