import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import '../../provider/user.dart';
import '../../services/supaAuth.dart';
import '../../widgets/layout.dart';
import '../../widgets/default.dart';
import '../../utility/screensize.dart';
import '../../utility/constants.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void onTapSignUp() async {
      setState(() {
        _isLoading = true;
      });

      final userAuthStatus = await SupaAuth.signUp(
        email: usernameController.text,
        password: passwordController.text,
      );

      if (userAuthStatus["errorMsg"] != null) {
        final snackBar = SnackBar(
          content: Text(userAuthStatus["errorMsg"]),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          _isLoading = false;
        });
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: kampongDefaultAppBar(),
        body: KampongPaddedSafeArea(
          child: KampongFullScreenContainer(
            child: Container(
              padding: EdgeInsets.all(20),
              child: KampongColumnSpaceBetweenStretch(children: [
                Expanded(
                  flex: 3,
                  child: KampongColumnCenterCenter(
                    children: [
                      // Image(
                      //   image: AssetImage('images/logo.png'),
                      //   width: ScreenSize.safeAreaWidth(context) < 800
                      //       ? ScreenSize.safeAreaWidth(context) * 0.6
                      //       : 700,
                      // ),
                      TextField(
                        decoration: InputDecoration(labelText: "Email"),
                        controller: usernameController,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: "Password"),
                        controller: passwordController,
                        obscureText: true,
                        autocorrect: false,
                        enableSuggestions: false,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: onTapSignUp,
                          style: ElevatedButton.styleFrom(
                            primary: KampongColors.blue,
                            textStyle: KampongFonts.label,
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
