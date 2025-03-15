import 'package:flutter/material.dart';

class HadithScreen extends StatelessWidget {
  final List<Map<String, String>> hadiths = [
    {
      "title": "حديث عن النية",
      "content": "قال رسول الله ﷺ: «إنما الأعمال بالنيات، وإنما لكل امرئ ما نوى...»"
    },
    {
      "title": "حديث عن الأخلاق",
      "content": "قال رسول الله ﷺ: «إنما بعثت لأتمم مكارم الأخلاق.»"
    },
    {
      "title": "حديث عن بر الوالدين",
      "content": "قال رسول الله ﷺ: «رِضَا اللَّهِ فِي رِضَا الْوَالِدِ، وَسَخَطُ اللَّهِ فِي سَخَطِ الْوَالِدِ.»"
    },
    {
      "title": "حديث عن الصدقة",
      "content": "قال رسول الله ﷺ: «الصدقة تطفئ الخطيئة كما يطفئ الماء النار.»"
    },
    {
      "title": "حديث عن الاستغفار",
      "content": "قال رسول الله ﷺ: «من لزم الاستغفار جعل الله له من كل ضيق مخرجًا...»"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("أحاديث نبوية"),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: hadiths.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hadiths[index]["title"]!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    hadiths[index]["content"]!,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
