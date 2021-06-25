import 'package:flutter/material.dart';

import '../widgets/layout.dart';
import '../services/firebaseAuthClient.dart';
import '../widgets/default.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PaddedSafeArea(
      child: FullScreenContainer(
        child: ColumnCenterCenter(
          children: [
            PowerButton(
              child: Text("sign up"),
              onPressed: () {
                FirebaseAuthClient.signInWithGoogle();
              },
            )
          ],
        ),
      ),
    ));
  }
}
