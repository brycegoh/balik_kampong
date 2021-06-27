import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/layout.dart';
import '../../utility/screensize.dart';
import '../../utility/constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KampongPaddedSafeArea(
      child: KampongFullScreenContainer(
        child: Container(
          padding: EdgeInsets.all(10),
          constraints: BoxConstraints(
            maxWidth: ScreenSize.safeAreaWidth(context) * 0.2,
          ),
          color: KampongColors.white,
        ),
      ),
    );
  }
}
