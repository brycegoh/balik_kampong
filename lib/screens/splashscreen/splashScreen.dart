import 'package:balik_kampong/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../../utility/screensize.dart';
import '../../services/supaAuth.dart';
import '../navbar/app.dart';
import '../../provider/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  late Future _startApp;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await SupaAuth.recoverSessionOnResume();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initStartup(context),
      builder: (context, snapshot) {
        return _kampongSplashScreen();
      },
    );
  }

  Future<dynamic> _initStartup(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context);
    Map<String, dynamic> response = await userProvider.persistUser();
    if (response["success"] && response["isOnboard"]) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else if (response["success"] && !response["isOnboard"]) {
      Navigator.pushNamedAndRemoveUntil(context, '/onboard', (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Widget _kampongSplashScreen() {
    return Container(
      height: ScreenSize.safeAreaHeight(context),
      width: ScreenSize.safeAreaWidth(context),
      constraints: BoxConstraints(
        maxWidth: ScreenSize.safeAreaWidth(context) * 0.8,
      ),
      child: KampongColumnCenterCenter(
        children: [
          // Lottie.asset(
          //   'lottie/food-on-the-table.json',
          // ),
        ],
      ),
    );
  }
}
