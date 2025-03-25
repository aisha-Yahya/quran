import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thikr/helpers/theme_provider.dart';
import 'package:thikr/screens/home_screen.dart'; // تأكد من الاستيراد هنا
import 'package:geolocator/geolocator.dart'; // تأكد من استيراد الحزمة

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestLocationPermission(); // طلب إذن الموقع
  runApp(MyApp());
}

Future<void> requestLocationPermission() async {
  // طلب إذن الموقع
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    // يمكنك هنا إعلام المستخدم بأهمية الإذن أو معالجة الرفض.
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
            home: ReligiousAppHome(
              toggleTheme: themeProvider.toggleTheme,
              isDark: themeProvider.isDarkMode,
            ),
          );
        },
      ),
    );
  }
}
