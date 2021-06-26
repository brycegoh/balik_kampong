import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import '../events/browseEvent.dart';
import '../communities/browseCommunities.dart';
import '../food/browseFood.dart';
import '../../widgets/appBar.dart';
import '../../utility/constants.dart';
import '../../widgets/default.dart';

class AppScreen extends StatefulWidget {
  int tabIndex;
  AppScreen({Key? key, required this.tabIndex}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int currentIndex = 0;
  List<String> tabs = ["home", "community", "event", "food"];

  @override
  void initState() {
    super.initState();
    setState(() {
      currentIndex = widget.tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: kampongDefaultAppBar(),
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeScreen(),
          BrowseCommunitiesScreen(),
          BrowseEventScreen(),
          BrowseFoodScreen(),
        ],
      ), // new
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: (int nextIndex) {
          setState(() {
            currentIndex = nextIndex;
          });
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(
              TablerIcons.smart_home,
              size: 30,
            ),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              TablerIcons.users,
              size: 27,
            ),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              TablerIcons.ticket,
              size: 27,
            ),
            label: "",
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              TablerIcons.meat,
              size: 27,
            ),
            label: "",
          ),
        ],
      ),
    );
  }
}
