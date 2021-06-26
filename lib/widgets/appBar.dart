import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

//local imports
import '../provider/user.dart';
import '../utility/constants.dart';

class KampongAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? trailing;
  final Widget? leading;
  final Text? header;
  final Widget? headerWidget;
  final Color? color;

  KampongAppBar({
    this.trailing,
    this.leading,
    this.header,
    this.color,
    this.headerWidget,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    var userProvider = context.read<UserProvider>();
    return Container(
      child: AppBar(
        brightness: Brightness.light,
        backgroundColor: color ?? KampongColors.blue,
        shadowColor: Colors.transparent,
        elevation: 0.0,
        leading: !Navigator.canPop(context)
            ? null
            : IconButton(
                onPressed: () {
                  Navigator.maybePop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black87,
                ),
              ),
        title: this.headerWidget ?? this.header ?? Text(''),
        centerTitle: false,
        actions: [
          Container(child: trailing ?? Container()),
        ],
      ),
    );
  }
}
