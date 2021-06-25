import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'services/firestoreClient.dart';
import './routes/fluroRouter.dart';
import './provider/globalprovider.dart';
import './screens/splashScreen.dart';

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
    await Firebase.initializeApp();
    await FirestoreClient.addUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initApp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => GlobalProvider()),
            ],
            child: MaterialApp(
              title: 'powerpuff',
              theme: ThemeData(
                backgroundColor: Colors.white,
              ),
              onGenerateRoute: PowerPuffRouter.powerRouter.generator,
              home: SplashScreen(),
            ),
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
