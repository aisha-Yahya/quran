import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thikr/helpers/theme_provider.dart';
import 'package:thikr/screens/home_screen.dart'; // تأكد من صحة المسار
import 'package:geolocator/geolocator.dart';

Future<void> main() async {
  // --- مهم جداً للـ Plugins مثل geolocator و google_maps_flutter ---
  WidgetsFlutterBinding.ensureInitialized();
  // ----------------------------------------------------------------

  // طلب إذن الموقع عند بدء التشغيل (يمكن نقله إلى داخل الشاشة إذا أردت)
  await requestLocationPermission();
  runApp(const MyApp()); // استخدم const إذا كان MyApp لا يتغير
}

Future<void> requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("تم رفض إذن الموقع.");
      // يمكنك عرض رسالة للمستخدم هنا إذا أردت
    }
  }

  if (permission == LocationPermission.deniedForever) {
    print("تم رفض إذن الموقع بشكل دائم.");
    // يمكنك عرض رسالة لتوجيه المستخدم للإعدادات
    // await Geolocator.openAppSettings();
  }

  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    print("تم الحصول على إذن الموقع.");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            // تأكد من أن ReligiousAppHome موجودة أو استبدلها بشاشتك الرئيسية الصحيحة
            home: ReligiousAppHome(
              toggleTheme: themeProvider.toggleTheme,
              isDark: themeProvider.isDarkMode,
            ),
            // يمكنك إضافة routes هنا إذا كان لديك شاشات متعددة
            /* routes: {
               '/nearby': (context) => NearbyMosquesScreen(),
               // ... other routes
             }, */
          );
        },
      ),
    );
  }
}
