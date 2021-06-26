import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../widgets/layout.dart';
import '../widgets/appBar.dart';
import '../utility/constants.dart';
import '../utility/screensize.dart';

class KampongButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;

  const KampongButton(
      {Key? key,
      required this.onPressed,
      required this.isLoading,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: KampongColors.blue,
          textStyle: KampongFonts.label,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              )
            : Text(text),
      ),
    );
  }
}

class KampongInptChips extends StatelessWidget {
  final Function(bool) onSelected;
  final bool isSelected;
  final String label;
  final bool isEnabled;

  KampongInptChips({
    required this.onSelected,
    required this.label,
    required this.isSelected,
    this.isEnabled = true,
  });

  final Color notSelectedColor = KampongColors.sand;
  final Color selectedColor = KampongColors.tangerine;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      isEnabled: isEnabled,
      backgroundColor: isSelected ? selectedColor : notSelectedColor,
      label: FittedBox(
        fit: BoxFit.contain,
        child: KampongRowStartCenter(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(label),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 4),
              child: isSelected
                  ? Icon(TablerIcons.check, size: 20)
                  : Icon(TablerIcons.plus, size: 20),
            ),
          ],
        ),
      ),
      onSelected: onSelected,
    );
  }
}

class KampongTile extends StatelessWidget {
  final VoidCallback onTap;
  final String text, imageUrl;

  const KampongTile({
    Key? key,
    required this.onTap,
    required this.text,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = ScreenSize.safeAreaHeight(context) * 0.3;
    double width = ScreenSize.safeAreaWidth(context) * 0.75;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: KampongColors.sand,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(
                  imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(148, 157, 164, 0.35),
              borderRadius: BorderRadius.circular(20),
            ),
            height: height,
            width: width,
            margin: EdgeInsets.all(10),
          ),
          Positioned(
            width: width * 0.8,
            bottom: 20,
            left: 30,
            child: Text(
              text,
              style: KampongFonts.tileText,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}

class KampongTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final EdgeInsets margin;

  const KampongTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextField(
        decoration: InputDecoration(labelText: labelText),
        controller: controller,
      ),
    );
  }
}

PreferredSizeWidget kampongDefaultAppBar() {
  return KampongAppBar(
      color: KampongColors.transparent,
      trailing: Container(
        padding: EdgeInsets.all(10),
        child: IconButton(
          onPressed: () {
            print("hello");
          },
          icon: Icon(
            TablerIcons.phone_call,
            color: KampongColors.red,
            size: 30,
          ),
        ),
      ));
}

class KampongChips extends StatelessWidget {
  final String tag;
  const KampongChips({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: KampongColors.black, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: KampongColors.transparent,
      label: FittedBox(
          fit: BoxFit.contain,
          child: KampongColumnStartCenter(children: [
            Container(
                padding: const EdgeInsets.only(bottom: 8.0), child: Text(tag))
          ])),
    );
  }
}
