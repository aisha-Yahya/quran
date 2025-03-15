import 'package:flutter/material.dart';
import 'package:piri_qiblah/piri_qiblah.dart';
import 'package:permission_handler/permission_handler.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({super.key});

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen> {
  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      var result = await Permission.location.request();
      if (result.isDenied) {
        await Permission.location.request();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اتجاه القبلة'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.blue.shade200],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'اتجاه القبلة',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const SizedBox(
                    height: 300,
                    width: 300,
                    child: PiriQiblah(
                      permissionDeniedMessage:
                          'يرجى السماح بالوصول إلى الموقع لتحديد القبلة',
                      useDefaultAssets: true,
                      defaultNeedleColor: Colors.red, // تغيير لون الإبرة للوضوح
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
