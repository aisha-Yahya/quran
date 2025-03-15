import 'package:flutter/material.dart';

class QuranImageScreen extends StatefulWidget {
  final int initialPage;

  const QuranImageScreen({Key? key, required this.initialPage})
      : super(key: key);

  @override
  _QuranImageScreenState createState() => _QuranImageScreenState();
}

class _QuranImageScreenState extends State<QuranImageScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القرآن الكريم'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: 604, // عدد الصفحات في القرآن
        itemBuilder: (context, index) {
          String pageNumber = (index + 1).toString().padLeft(3, '0');
          String imagePath = 'assets/quran-images/page$pageNumber.png';

          // إضافة Print هنا لعرض مسار الصورة في الـ Debug Console
          print('تحميل الصورة: $imagePath');

          return Center(
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 50, color: Colors.red),
                    const SizedBox(height: 10),
                    Text(
                      '⚠️ تعذر تحميل الصورة:\n$imagePath',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
