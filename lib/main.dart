import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/ui/intro/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('home_kriya_count');
  await Hive.openBox('long_kriya_count');
  await Hive.openBox('total_seva_done_count');
  await Hive.openBox('lastKriyaDate');

  if (Hive.box('home_kriya_count').length == 0) {
    Hive.box('home_kriya_count').put(0, 0);
  }

  FirebaseDatabase database = FirebaseDatabase.instance;
  database.setPersistenceEnabled(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
