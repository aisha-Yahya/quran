import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:url_launcher/url_launcher.dart'; // يمكنك إضافته إذا أردت زر لفتح الخرائط الخارجية

class MosqueMapScreen extends StatefulWidget {
  final Map<String, dynamic> mosque;

  const MosqueMapScreen({super.key, required this.mosque});

  @override
  State<MosqueMapScreen> createState() => _MosqueMapScreenState();
}

class _MosqueMapScreenState extends State<MosqueMapScreen> {
  late GoogleMapController mapController;
  LatLng? _mosqueLocation;
  String _mosqueName = "موقع المسجد";
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _parseMosqueData();
  }

  void _parseMosqueData() {
    // استخدام lng بدلاً من lon
    double? lat = widget.mosque["lat"] is double
        ? widget.mosque["lat"]
        : double.tryParse(widget.mosque["lat"].toString());
    double? lng = widget.mosque["lng"] is double // <-- التغيير هنا
        ? widget.mosque["lng"]
        : double.tryParse(widget.mosque["lng"].toString()); // <-- التغيير هنا

    _mosqueName = widget.mosque["name"] ?? "اسم المسجد غير متوفر";

    if (lat != null && lng != null) {
      _mosqueLocation = LatLng(lat, lng);
      // إضافة علامة للمسجد
      _markers.add(
        Marker(
          markerId: MarkerId(widget.mosque['place_id'] ?? 'mosque_location'),
          position: _mosqueLocation!,
          infoWindow: InfoWindow(
            title: _mosqueName,
            snippet: widget.mosque["vicinity"] ?? '', // عرض العنوان إن وجد
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure), // تغيير لون العلامة
        ),
      );
    } else {
      // التعامل مع حالة عدم وجود إحداثيات صالحة
      print("⚠️ خطأ: إحداثيات المسجد غير صالحة.");
      _mosqueLocation = null; // أو يمكنك تعيين موقع افتراضي أو عرض رسالة خطأ
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // يمكنك هنا تحريك الكاميرا بشكل إضافي إذا أردت
    if (_mosqueLocation != null) {
      // يمكنك إضافة تأثير حركة بسيط
      controller
          .animateCamera(CameraUpdate.newLatLngZoom(_mosqueLocation!, 15));
    }
  }

/*
  // --- اختيارية: دالة لفتح الموقع في تطبيق خرائط خارجي ---
  void _openInExternalMaps() async {
    if (_mosqueLocation == null) return;

    final lat = _mosqueLocation!.latitude;
    final lon = _mosqueLocation!.longitude; // url_launcher يستخدم lon
    final label = Uri.encodeComponent(_mosqueName); // تشفير الاسم للرابط

    // رابط لـ Google Maps
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lon($label)');

    // رابط بديل لخرائط آبل (يعمل فقط على iOS)
     final Uri appleMapsUrl = Uri.parse(
         'maps://?q=$label&ll=$lat,$lon');


    if (await canLaunchUrl(googleMapsUrl)) { // محاولة فتح خرائط جوجل أولاً
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(appleMapsUrl)) { // محاولة فتح خرائط آبل كبديل
        await launchUrl(appleMapsUrl, mode: LaunchMode.externalApplication);
    }
    else {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذر فتح تطبيق الخرائط')),
      );
      print('تعذر فتح الخرائط لـ $lat,$lon');
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_mosqueName),
        backgroundColor: Colors.teal, // توحيد اللون
      ),
      body: _mosqueLocation == null
          ? const Center(
              child: Text(
                "موقع المسجد غير متوفر أو غير صحيح.",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _mosqueLocation!,
                zoom: 15.0, // مستوى التقريب الأولي
              ),
              markers: _markers, // عرض العلامة التي أنشأناها
              mapType: MapType
                  .normal, // نوع الخريطة (normal, satellite, terrain, hybrid)
              myLocationEnabled:
                  true, // عرض موقع المستخدم الحالي (يتطلب إذن الموقع)
              myLocationButtonEnabled:
                  true, // زر لإعادة التمركز على موقع المستخدم
              zoomControlsEnabled: true, // إظهار أزرار التحكم بالتقريب
            ),
      /* // --- اختيارية: إضافة زر عائم لفتح الخرائط الخارجية ---
       floatingActionButton: _mosqueLocation == null ? null : FloatingActionButton.extended(
          onPressed: _openInExternalMaps,
          label: Text('الاتجاهات'),
          icon: Icon(Icons.directions),
          backgroundColor: Colors.teal,
       ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // موقع الزر
      */
    );
  }
}
