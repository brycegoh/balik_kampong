import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/fontSize.dart';
import './routes/fluroRouter.dart';
import './screens/splashscreen/splashScreen.dart';

class MApp extends StatelessWidget {
  const MApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<FontProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Balik Kampung',
      theme: ThemeData(
        fontFamily: 'AvenirNext',
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25 * fontProvider.multiplier,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 23 * fontProvider.multiplier,
          ),
          headline3: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20 * fontProvider.multiplier,
            color: Colors.black,
          ),
          headline4: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 17 * fontProvider.multiplier,
            color: Colors.black87,
          ),
          headline5: TextStyle(
            fontSize: 17 * fontProvider.multiplier,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          headline6: TextStyle(
            fontSize: 17 * fontProvider.multiplier,
            fontWeight: FontWeight.w300,
          ),
          bodyText1: TextStyle(
            fontSize: 12 * fontProvider.multiplier,
          ),
          bodyText2: TextStyle(
            fontSize: 15 * fontProvider.multiplier,
            color: Colors.blue,
          ),
        ),
      ),
      onGenerateRoute: PowerPuffRouter.powerRouter.generator,
      home: SplashScreen(),
    );
  }
}
