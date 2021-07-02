import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './routes/fluroRouter.dart';
import 'provider/user.dart';
import 'provider/fontSize.dart';
import 'screens/splashscreen/splashScreen.dart';
import './utility/hiveBox.dart';
import './MaterialApp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future _initApp;

  @override
  void initState() {
    _initApp = _init();
    super.initState();
  }

  Future<void> _init() async {
    PowerPuffRouter.initRouter();
    await HiveBox.initHive();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initApp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => UserProvider()),
              ChangeNotifierProvider(create: (context) => FontProvider()),
            ],
            child: MApp(),
          );
        } else {
          return Container(
            color: Colors.white,
          );
        }
      },
    );
  }
}
