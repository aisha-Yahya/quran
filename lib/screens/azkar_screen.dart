import 'package:flutter/material.dart';

class AzkarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أذكار',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AzkarCategoryScreen(),
    );
  }
}

class AzkarCategoryScreen extends StatelessWidget {
  final Map<String, List<Azkar>> azkarData = {
    "أذكار الصباح": [
      Azkar(
        title: "آية الكرسي",
        content:
            "اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ مَنْ ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضِ وَلَا يَئُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.",
        requiredCount: 1,
      ),
      Azkar(
        title: "سورة الإخلاص",
        content:
            "قُلْ هُوَ اللَّهُ أَحَدٌ اللَّهُ الصَّمَدُ لَمْ يَلِدْ وَلَمْ يُولَدْ وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ.",
        requiredCount: 3,
      ),
      Azkar(
        title: "سورة الفلق",
        content:
            "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ مِنْ شَرِّ مَا خَلَقَ وَمِنْ شَرِّ غَاسِقٍ إِذَا وَقَبَ وَمِنْ شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ.",
        requiredCount: 3,
      ),
      Azkar(
        title: "سورة الناس",
        content:
            "قُلْ أَعُوذُ بِرَبِّ النَّاسِ مَلِكِ النَّاسِ إِلَهِ النَّاسِ مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ مِنَ الْجِنَّةِ وَالنَّاسِ.",
        requiredCount: 3,
      ),
      Azkar(
        title: "سيد الاستغفار",
        content:
            "اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ خَلَقْتَنِي وَأَنَا عَبْدُكَ وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ.",
        requiredCount: 1,
      ),
      Azkar(
        title: "اللهم إني أصبحت أشهدك",
        content:
            "اللهم إني أصبحت أشهدك وأشهد حملة عرشك وملائكتك وجميع خلقك، أنك أنت الله لا إله إلا أنت وحدك لا شريك لك، وأن محمداً عبدك ورسولك.",
        requiredCount: 4,
      ),
      Azkar(
        title: "اللهم ما أصبح بي من نعمة",
        content:
            "اللهم ما أصبح بي من نعمة أو بأحد من خلقك، فمنك وحدك لا شريك لك، فلك الحمد ولك الشكر.",
        requiredCount: 1,
      ),
      Azkar(
        title: "رضيت بالله ربًا",
        content: "رضيت بالله ربًا، وبالإسلام دينًا، وبمحمد ﷺ نبيًا.",
        requiredCount: 3,
      ),
      Azkar(
        title: "اللهم عافني في بدني",
        content:
            "اللهم عافني في بدني، اللهم عافني في سمعي، اللهم عافني في بصري، لا إله إلا أنت.",
        requiredCount: 3,
      ),
      Azkar(
        title: "اللهم إني أعوذ بك من الكفر والفقر",
        content:
            "اللهم إني أعوذ بك من الكفر، والفقر، وأعوذ بك من عذاب القبر، لا إله إلا أنت.",
        requiredCount: 3,
      ),
      Azkar(
        title: "اللهم بك أصبحنا",
        content:
            "اللهم بك أصبحنا، وبك أمسينا، وبك نحيا، وبك نموت، وإليك النشور.",
        requiredCount: 1,
      ),
      Azkar(
        title: "أصبحنا وأصبح الملك لله",
        content:
            "أصبحنا وأصبح الملك لله، والحمد لله، لا إله إلا الله وحده لا شريك له، له الملك وله الحمد، وهو على كل شيء قدير، ربِّ أسألك خير ما في هذا اليوم وخير ما بعده، وأعوذ بك من شر ما في هذا اليوم وشر ما بعده، ربِّ أعوذ بك من الكسل وسوء الكبر، ربِّ أعوذ بك من عذاب في النار وعذاب في القبر.",
        requiredCount: 1,
      ),
      Azkar(
        title: "اللهم إني أسألك العافية",
        content:
            "اللهم إني أسألك العافية في الدنيا والآخرة، اللهم إني أسألك العفو والعافية في ديني ودنياي وأهلي ومالي، اللهم استر عوراتي، وآمن روعاتي، اللهم احفظني من بين يديَّ ومن خلفي، وعن يميني وعن شمالي، ومن فوقي، وأعوذ بعظمتك أن أغتال من تحتي.",
        requiredCount: 1,
      ),
      Azkar(
        title: "يا حي يا قيوم",
        content:
            "يا حي يا قيوم برحمتك أستغيث، أصلح لي شأني كله، ولا تكلني إلى نفسي طرفة عين.",
        requiredCount: 3,
      ),
      Azkar(
        title: "أعوذ بكلمات الله التامات",
        content: "أعوذ بكلمات الله التامات من شر ما خلق.",
        requiredCount: 3,
      ),
      Azkar(
        title: "حسبي الله لا إله إلا هو",
        content: "حسبي الله لا إله إلا هو عليه توكلت وهو رب العرش العظيم.",
        requiredCount: 7,
      ),
      Azkar(
        title: "بسم الله الذي لا يضر مع اسمه شيء",
        content:
            "بسم الله الذي لا يضر مع اسمه شيء في الأرض ولا في السماء وهو السميع العليم.",
        requiredCount: 3,
      ),
      Azkar(
        title: "اللهم صل وسلم على نبينا محمد",
        content: "اللهم صل وسلم على نبينا محمد.",
        requiredCount: 10,
      ),
      Azkar(
        title: "سبحان الله وبحمده",
        content: "سبحان الله وبحمده.",
        requiredCount: 100,
      ),
      Azkar(
        title: "لا إله إلا الله وحده لا شريك له",
        content:
            "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير.",
        requiredCount: 10,
      ),
    ],
    "أذكار المساء": [
  Azkar(
    title: "آية الكرسي",
    content:
        "اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَنْ ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۚ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ.",
    requiredCount: 1,
  ),
  Azkar(
    title: "أمسينا وأمسى الملك لله",
    content: "أمسينا وأمسى الملك لله، والحمد لله، لا إله إلا الله وحده لا شريك له، له الملك وله الحمد، وهو على كل شيء قدير، ربِّ أسألك خير ما في هذه الليلة وخير ما بعدها، وأعوذ بك من شر ما في هذه الليلة وشر ما بعدها، ربِّ أعوذ بك من الكسل وسوء الكبر، ربِّ أعوذ بك من عذاب في النار وعذاب في القبر.",
    requiredCount: 1,
  ),
  Azkar(
    title: "سورة الإخلاص",
    content: "قُلْ هُوَ اللَّهُ أَحَدٌ اللَّهُ الصَّمَدُ لَمْ يَلِدْ وَلَمْ يُولَدْ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ.",
    requiredCount: 3,
  ),
  Azkar(
    title: "سورة الفلق",
    content: "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ مِن شَرِّ مَا خَلَقَ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ.",
    requiredCount: 3,
  ),
  Azkar(
    title: "سورة الناس",
    content: "قُلْ أَعُوذُ بِرَبِّ النَّاسِ مَلِكِ النَّاسِ إِلَٰهِ النَّاسِ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ مِنَ الْجِنَّةِ وَالنَّاسِ.",
    requiredCount: 3,
  ),
  Azkar(
    title: "سيد الاستغفار",
    content: "اللهم أنت ربي لا إله إلا أنت خلقتني وأنا عبدك وأنا على عهدك ووعدك ما استطعت، أعوذ بك من شر ما صنعت، أبوء لك بنعمتك علي، وأبوء بذنبي فاغفر لي، فإنه لا يغفر الذنوب إلا أنت.",
    requiredCount: 1,
  ),
  Azkar(
    title: "اللهم إني أمسيت أشهدك",
    content: "اللهم إني أمسيت أشهدك وأشهد حملة عرشك وملائكتك وجميع خلقك، أنك أنت الله لا إله إلا أنت وحدك لا شريك لك، وأن محمداً عبدك ورسولك.",
    requiredCount: 4,
  ),
  Azkar(
    title: "اللهم ما أمسى بي من نعمة",
    content: "اللهم ما أمسى بي من نعمة أو بأحد من خلقك، فمنك وحدك لا شريك لك، فلك الحمد ولك الشكر.",
    requiredCount: 1,
  ),
  Azkar(
    title: "رضيت بالله ربًا",
    content: "رضيت بالله ربًا، وبالإسلام دينًا، وبمحمد ﷺ نبيًا.",
    requiredCount: 3,
  ),
  Azkar(
    title: "بسم الله الذي لا يضر مع اسمه شيء",
    content: "بسم الله الذي لا يضر مع اسمه شيء في الأرض ولا في السماء وهو السميع العليم.",
    requiredCount: 3,
  ),
  Azkar(
    title: "حسبي الله لا إله إلا هو",
    content: "حسبي الله لا إله إلا هو عليه توكلت وهو رب العرش العظيم.",
    requiredCount: 7,
  ),
  Azkar(
    title: "سبحان الله وبحمده",
    content: "سبحان الله وبحمده.",
    requiredCount: 100,
  ),
  Azkar(
    title: "لا إله إلا الله وحده لا شريك له",
    content: "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير.",
    requiredCount: 10,
  ),
  Azkar(
    title: "اللهم صل وسلم على نبينا محمد",
    content: "اللهم صل وسلم على نبينا محمد.",
    requiredCount: 10,
  ),


    ],
    "دعاء السفر": [
      
  Azkar(
    title: "دعاء ركوب الدابة أو السيارة",
    content: "سبحان الذي سخر لنا هذا وما كنا له مقرنين وإنا إلى ربنا لمنقلبون.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء السفر",
    content: "اللهم إنا نسألك في سفرنا هذا البر والتقوى، ومن العمل ما ترضى، اللهم هون علينا سفرنا هذا واطوِ عنا بعده، اللهم أنت الصاحب في السفر والخليفة في الأهل.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء دخول القرية أو المدينة",
    content: "اللهم رب السماوات السبع وما أظللن، ورب الأرضين السبع وما أقللن، ورب الشياطين وما أضللن، ورب الرياح وما ذرين، أسألك خير هذه القرية وخير أهلها وخير ما فيها، ونعوذ بك من شرها وشر أهلها وشر ما فيها.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء المسافر للمقيم",
    content: "أستودعكم الله الذي لا تضيع ودائعه.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء المقيم للمسافر",
    content: "أستودع الله دينك وأمانتك وخواتيم عملك، زودك الله التقوى، وغفر ذنبك، ويسر لك الخير حيثما كنت.",
    requiredCount: 1,
  ),
  Azkar(
    title: "التكبير والتسبيح في السفر",
    content: "كان النبي ﷺ إذا علا مرتفعًا كبر، وإذا هبط واديًا سبح.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء الرجوع من السفر",
    content: "آيبون تائبون عابدون لربنا حامدون.",
    requiredCount: 1,
  ),
    ],

    "دعاء الدخول الى المسجد ": [
      
  Azkar(
    title: "دعاء ركوب الدابة أو السيارة",
    content: "سبحان الذي سخر لنا هذا وما كنا له مقرنين وإنا إلى ربنا لمنقلبون.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء السفر",
    content: "اللهم إنا نسألك في سفرنا هذا البر والتقوى، ومن العمل ما ترضى، اللهم هون علينا سفرنا هذا واطوِ عنا بعده، اللهم أنت الصاحب في السفر والخليفة في الأهل.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء دخول القرية أو المدينة",
    content: "اللهم رب السماوات السبع وما أظللن، ورب الأرضين السبع وما أقللن، ورب الشياطين وما أضللن، ورب الرياح وما ذرين، أسألك خير هذه القرية وخير أهلها وخير ما فيها، ونعوذ بك من شرها وشر أهلها وشر ما فيها.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء المسافر للمقيم",
    content: "أستودعكم الله الذي لا تضيع ودائعه.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء المقيم للمسافر",
    content: "أستودع الله دينك وأمانتك وخواتيم عملك، زودك الله التقوى، وغفر ذنبك، ويسر لك الخير حيثما كنت.",
    requiredCount: 1,
  ),
  Azkar(
    title: "التكبير والتسبيح في السفر",
    content: "كان النبي ﷺ إذا علا مرتفعًا كبر، وإذا هبط واديًا سبح.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء الرجوع من السفر",
    content: "آيبون تائبون عابدون لربنا حامدون.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء دخول المسجد",
    content: "اللهم افتح لي أبواب رحمتك.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء الخروج من المسجد",
    content: "اللهم إني أسألك من فضلك.",
    requiredCount: 1,
  ),


    ],
    "دعاء الخروج من المسجد": [
      Azkar(
  title: "دعاء الخروج من المسجد",
  content: "اللهم إني أسألك من فضلك.",
  requiredCount: 1,
),
],
"دعاء الدخول والخروج من المنزل": [

  Azkar(
    title: "دعاء ركوب الدابة أو السيارة",
    content: "سبحان الذي سخر لنا هذا وما كنا له مقرنين وإنا إلى ربنا لمنقلبون.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء السفر",
    content: "اللهم إنا نسألك في سفرنا هذا البر والتقوى، ومن العمل ما ترضى، اللهم هون علينا سفرنا هذا واطوِ عنا بعده، اللهم أنت الصاحب في السفر والخليفة في الأهل.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء دخول القرية أو المدينة",
    content: "اللهم رب السماوات السبع وما أظللن، ورب الأرضين السبع وما أقللن، ورب الشياطين وما أضللن، ورب الرياح وما ذرين، أسألك خير هذه القرية وخير أهلها وخير ما فيها، ونعوذ بك من شرها وشر أهلها وشر ما فيها.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء المسافر للمقيم",
    content: "أستودعكم الله الذي لا تضيع ودائعه.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء المقيم للمسافر",
    content: "أستودع الله دينك وأمانتك وخواتيم عملك، زودك الله التقوى، وغفر ذنبك، ويسر لك الخير حيثما كنت.",
    requiredCount: 1,
  ),
  Azkar(
    title: "التكبير والتسبيح في السفر",
    content: "كان النبي ﷺ إذا علا مرتفعًا كبر، وإذا هبط واديًا سبح.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء الرجوع من السفر",
    content: "آيبون تائبون عابدون لربنا حامدون.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء دخول المسجد",
    content: "اللهم افتح لي أبواب رحمتك.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء الخروج من المسجد",
    content: "اللهم إني أسألك من فضلك.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء دخول المنزل",
    content: "بسم الله ولجنا، وبسم الله خرجنا، وعلى الله ربنا توكلنا.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء الخروج من المنزل",
    content: "بسم الله توكلت على الله، ولا حول ولا قوة إلا بالله.",
    requiredCount: 1,
  ),
],
"اذكار بعد كل صلاة": [
  Azkar(
    title: "دعاء ركوب الدابة أو السيارة",
    content: "سبحان الذي سخر لنا هذا وما كنا له مقرنين وإنا إلى ربنا لمنقلبون.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء السفر",
    content: "اللهم إنا نسألك في سفرنا هذا البر والتقوى، ومن العمل ما ترضى، اللهم هون علينا سفرنا هذا واطوِ عنا بعده، اللهم أنت الصاحب في السفر والخليفة في الأهل.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء دخول القرية أو المدينة",
    content: "اللهم رب السماوات السبع وما أظللن، ورب الأرضين السبع وما أقللن، ورب الشياطين وما أضللن، ورب الرياح وما ذرين، أسألك خير هذه القرية وخير أهلها وخير ما فيها، ونعوذ بك من شرها وشر أهلها وشر ما فيها.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء المسافر للمقيم",
    content: "أستودعكم الله الذي لا تضيع ودائعه.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء المقيم للمسافر",
    content: "أستودع الله دينك وأمانتك وخواتيم عملك، زودك الله التقوى، وغفر ذنبك، ويسر لك الخير حيثما كنت.",
    requiredCount: 1,
  ),
  Azkar(
    title: "التكبير والتسبيح في السفر",
    content: "كان النبي ﷺ إذا علا مرتفعًا كبر، وإذا هبط واديًا سبح.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء الرجوع من السفر",
    content: "آيبون تائبون عابدون لربنا حامدون.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء دخول المسجد",
    content: "اللهم افتح لي أبواب رحمتك.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء الخروج من المسجد",
    content: "اللهم إني أسألك من فضلك.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء دخول المنزل",
    content: "بسم الله ولجنا، وبسم الله خرجنا، وعلى الله ربنا توكلنا.",
    requiredCount: 1,
  ),
  Azkar(
    title: "دعاء الخروج من المنزل",
    content: "بسم الله توكلت على الله، ولا حول ولا قوة إلا بالله.",
    requiredCount: 1,
  ),
  Azkar(
    title: "أذكار بعد الصلاة",
    content: "أستغفر الله، أستغفر الله، أستغفر الله. اللهم أنت السلام ومنك السلام تباركت يا ذا الجلال والإكرام.",
    requiredCount: 1,
  ),
  Azkar(
    title: "تسبيح بعد الصلاة",
    content: "سبحان الله 33 مرة، الحمد لله 33 مرة، الله أكبر 33 مرة، ثم تمام المئة: لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير.",
    requiredCount: 1,
  ),
  Azkar(
    title: "آية الكرسي بعد الصلاة",
    content: "اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَنْ ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۚ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ.",
    requiredCount: 1,
  ),
  Azkar(
    title: "سورة الإخلاص والمعوذتين بعد الصلاة",
    content: "قُلْ هُوَ اللَّهُ أَحَدٌ، قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ، قُلْ أَعُوذُ بِرَبِّ النَّاسِ.",
    requiredCount: 1,
  ),
],

    // يمكن إضافة بقية المجموعات هنا
    // يمكن إضافة بقية المجموعات هنا
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الأذكار'),
        backgroundColor: Colors.blue[600],
      ),
      body: ListView(
        children: azkarData.keys.map((categoryTitle) {
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                categoryTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AzkarDetailScreen(
                      title: categoryTitle,
                      azkarList: azkarData[categoryTitle]!,
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Azkar {
  final String title;
  final String content;
  final int requiredCount;

  Azkar({
    required this.title,
    required this.content,
    required this.requiredCount,
  });
}

class AzkarDetailScreen extends StatefulWidget {
  final String title;
  final List<Azkar> azkarList;

  AzkarDetailScreen({required this.title, required this.azkarList});

  @override
  _AzkarDetailScreenState createState() => _AzkarDetailScreenState();
}

class _AzkarDetailScreenState extends State<AzkarDetailScreen> {
  final Map<int, int> counts = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.azkarList.length; i++) {
      counts[i] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue[600],
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.azkarList.length,
        itemBuilder: (context, index) {
          final azkar = widget.azkarList[index];
          final count = counts[index] ?? 0;

          if (count >= azkar.requiredCount) {
            return Container();
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            shadowColor: Colors.blue[200],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    azkar.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    azkar.content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          counts[index] = (counts[index] ?? 0) + 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                      ),
                      child: Text(
                        "تم قراءته ${count + 1}/${azkar.requiredCount}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
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

void main() {
  runApp(AzkarApp());
}
