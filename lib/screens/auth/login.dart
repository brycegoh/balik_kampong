import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import '../../provider/user.dart';
import '../../widgets/layout.dart';
import '../../widgets/default.dart';
import '../../utility/screensize.dart';
import '../../widgets/appBar.dart';
import '../../utility/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = true;

  @override
  void initState() {
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    void onTapLogin() async {
      setState(() {
        isLoading = true;
      });

      final userAuthStatus = await userProvider.loginUser(
        username: usernameController.text,
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
          isLoading = false;
        });
      } else {
        if (userAuthStatus["user"] == null) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/onboard', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      }
    }

    Future onTapSignUp() async {
      Navigator.pushNamed(context, '/sign-up');
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                      KampongButton(
                        text: "Login",
                        onPressed: onTapLogin,
                        isLoading: isLoading,
                      ),
                      TextButton(
                        onPressed: isLoading ? null : onTapSignUp,
                        child: Text('Create an account'),
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
