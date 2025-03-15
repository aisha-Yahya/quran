import 'package:flutter/material.dart';
import 'package:thikr/screens/azkar_screen.dart';
import 'package:thikr/screens/calendar_screen.dart';
import 'package:thikr/screens/hadith_screen.dart';
import 'package:thikr/screens/qiblah_screen.dart';
import 'package:thikr/screens/tasbeeh_screen.dart';
import 'package:thikr/screens/QuranImageScreen.dart'; // شاشة عرض صور القرآن
import 'package:thikr/screens/SurahListScreen.dart'; // شاشة الفهرس
import 'package:thikr/screens/NearbyMosquesScreen.dart'; // شاشة المساجد القريبة

class ReligiousAppHome extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDark;

  const ReligiousAppHome({
    Key? key,
    required this.toggleTheme,
    required this.isDark,
  }) : super(key: key);

  @override
  _ReligiousAppHomeState createState() => _ReligiousAppHomeState();
}

class _ReligiousAppHomeState extends State<ReligiousAppHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDark ? Colors.black87 : Colors.white,
      appBar: AppBar(
        title: Text(
          'اذكر ورتل',
          style: TextStyle(
            color: widget.isDark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: widget.isDark ? Colors.black87 : Colors.white,
        elevation: 0,
        actions: [
          Switch(
            value: widget.isDark,
            onChanged: widget.toggleTheme,
            activeColor: Colors.amber,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.isDark
                    ? [Colors.grey.shade800, Colors.black87]
                    : [const Color(0xFF2B5876), const Color(0xFF4E4376)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'اذكر ورتل',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoNastaliqUrdu',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'الأربعاء، 12 ربيع الأول 1445',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    _buildFeatureCard(
                      context,
                      icon: Icons.format_list_bulleted,
                      title: 'فهرس القرآن',
                      gradient: widget.isDark
                          ? [Colors.grey.shade800, Colors.black87]
                          : [const Color(0xFF7F00FF), const Color(0xFFE100FF)],
                      screen: SurahListScreen(),
                    ),
                    _buildFeatureCard(
                      context,
                      icon: Icons.menu_book,
                      title: 'القرآن الكريم',
                      gradient: widget.isDark
                          ? [Colors.grey.shade800, Colors.black87]
                          : [const Color(0xFF348F50), const Color(0xFF56B4D3)],
                      screen: QuranImageScreen(initialPage: 0),
                    ),
                    _buildFeatureCard(
                      context,
                      icon: Icons.bookmark,
                      title: 'أذكار اليوم',
                      gradient: widget.isDark
                          ? [Colors.grey.shade800, Colors.black87]
                          : [const Color(0xFF4CA1AF), const Color(0xFF2C3E50)],
                      screen: AzkarCategoryScreen(),
                    ),
                    _buildFeatureCard(
                      context,
                      icon: Icons.calendar_today,
                      title: 'التقويم',
                      gradient: widget.isDark
                          ? [Colors.grey.shade800, Colors.black87]
                          : [const Color(0xFFFF8008), const Color(0xFFFFC837)],
                      screen: CalendarScreen(),
                    ),
                    _buildFeatureCard(
                      context,
                      icon: Icons.library_books,
                      title: 'الأحاديث',
                      gradient: widget.isDark
                          ? [Colors.grey.shade800, Colors.black87]
                          : [const Color(0xFF2196F3), const Color(0xFF21CBF3)],
                      screen: HadithScreen(),
                    ),
                    _buildFeatureCard(
                      context,
                      icon: Icons.explore,
                      title: 'تحديد القبلة',
                      gradient: widget.isDark
                          ? [Colors.grey.shade800, Colors.black87]
                          : [const Color(0xFF8E44AD), const Color(0xFFC0392B)],
                      screen: const QiblahScreen(),
                    ),
                    _buildFeatureCard(
                      context,
                      icon: Icons.place, // أيقونة المساجد القريبة
                      title: 'المساجد القريبة',
                      gradient: widget.isDark
                          ? [Colors.grey.shade800, Colors.black87]
                          : [const Color(0xFF8E44AD), const Color(0xFFC0392B)],
                      screen: NearbyMosquesScreen(), // شاشة المساجد القريبة
                    ),
                    _buildFeatureCard(
                      context,
                      icon: Icons.fingerprint,
                      title: 'عدّاد التسبيح',
                      gradient: widget.isDark
                          ? [Colors.grey.shade800, Colors.black87]
                          : [const Color(0xFF8E44AD), const Color(0xFFC0392B)],
                      screen: TasbeehScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon,
      required String title,
      required List<Color> gradient,
      required Widget screen}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
