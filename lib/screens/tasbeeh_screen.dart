import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbeehScreen extends StatefulWidget {
  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int subhanallahCount = 0;
  int alhamdulillahCount = 0;
  int allahuAkbarCount = 0;
  int laIlahaIllallahCount = 0;
  int astaghfirullahCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCounts();
  }

  Future<void> _loadCounts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      subhanallahCount = prefs.getInt('subhanallahCount') ?? 0;
      alhamdulillahCount = prefs.getInt('alhamdulillahCount') ?? 0;
      allahuAkbarCount = prefs.getInt('allahuAkbarCount') ?? 0;
      laIlahaIllallahCount = prefs.getInt('laIlahaIllallahCount') ?? 0;
      astaghfirullahCount = prefs.getInt('astaghfirullahCount') ?? 0;
    });
  }

  Future<void> _saveCounts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('subhanallahCount', subhanallahCount);
    await prefs.setInt('alhamdulillahCount', alhamdulillahCount);
    await prefs.setInt('allahuAkbarCount', allahuAkbarCount);
    await prefs.setInt('laIlahaIllallahCount', laIlahaIllallahCount);
    await prefs.setInt('astaghfirullahCount', astaghfirullahCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('عداد التسبيح')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildTasbeehRow(
              'سبحان الله',
              subhanallahCount,
              Colors.blue,
              () {
                setState(() {
                  subhanallahCount++;
                });
                _saveCounts();
              },
              () {
                setState(() {
                  subhanallahCount = 0;
                });
                _saveCounts();
              },
            ),
            buildTasbeehRow(
              'الحمد لله',
              alhamdulillahCount,
              Colors.green,
              () {
                setState(() {
                  alhamdulillahCount++;
                });
                _saveCounts();
              },
              () {
                setState(() {
                  alhamdulillahCount = 0;
                });
                _saveCounts();
              },
            ),
            buildTasbeehRow(
              'الله أكبر',
              allahuAkbarCount,
              Colors.orange,
              () {
                setState(() {
                  allahuAkbarCount++;
                });
                _saveCounts();
              },
              () {
                setState(() {
                  allahuAkbarCount = 0;
                });
                _saveCounts();
              },
            ),
            buildTasbeehRow(
              'لا إله إلا الله',
              laIlahaIllallahCount,
              Colors.purple,
              () {
                setState(() {
                  laIlahaIllallahCount++;
                });
                _saveCounts();
              },
              () {
                setState(() {
                  laIlahaIllallahCount = 0;
                });
                _saveCounts();
              },
            ),
            buildTasbeehRow(
              'استغفر الله',
              astaghfirullahCount,
              Colors.red,
              () {
                setState(() {
                  astaghfirullahCount++;
                });
                _saveCounts();
              },
              () {
                setState(() {
                  astaghfirullahCount = 0;
                });
                _saveCounts();
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildTasbeehRow(
    String title,
    int count,
    Color color,
    VoidCallback onIncrement,
    VoidCallback onReset,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            '$count',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: color),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onIncrement,
                style: ElevatedButton.styleFrom(backgroundColor: color),
                child: Text('تسبيح', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: onReset,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('تصفير', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
