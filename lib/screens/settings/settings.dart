import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/layout.dart';
import '../../widgets/default.dart';
import '../../utility/constants.dart';
import '../../utility/screensize.dart';
import '../../provider/fontSize.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double value = 1.0;

  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<FontProvider>(context, listen: true);
    return Scaffold(
      appBar: kampongDefaultAppBar(),
      body: KampongPaddedSafeArea(
        child: Container(
          height: ScreenSize.safeAreaHeight(context),
          width: ScreenSize.safeAreaWidth(context),
          margin: EdgeInsets.symmetric(horizontal: 11.5),
          child: KampongColumnStartStart(
            children: [
              _fontSlider(fontProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fontSlider(FontProvider fontProvider) {
    Map<double, String> mapper = {
      0.8: "SMALL",
      1.0: "DEFAULT",
      1.2: "MEDIUM",
      1.4: "LARGE",
    };

    return KampongColumnStartStart(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child:
              Text('Font Size', style: Theme.of(context).textTheme.headline1),
        ),
        Slider(
          value: fontProvider.multiplier,
          min: 0.8,
          max: 1.4,
          divisions: 3,
          label: mapper[fontProvider.multiplier],
          onChanged: (double x) {
            fontProvider.setMultiplier(x);
          },
        ),
      ],
    );
  }
}
