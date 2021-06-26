import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/layout.dart';
import '../../widgets/default.dart';
import '../../utility/constants.dart';
import '../../utility/screensize.dart';
import '../../services/supaCountries.dart';
import '../../services/supaCommunities.dart';
import '../../services/supaEvents.dart';
import '../../provider/user.dart';
import '../../models/country.dart';
import '../../models/community.dart';
import '../../models/event.dart';
import '../../models/user.dart';
import '../../models/interest.dart';
import '../../utility/hiveConstants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Box countryBox, communityBox, eventBox;
  String? dropdownValue;

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    UserData user = userProvider.user!;
    List<String> interests = user.interest;
    dropdownValue = user.countryName;

    countryBox = Hive.box<Country>(HiveBoxes.countries);
    communityBox = Hive.box<Community>(HiveBoxes.community);
    eventBox = Hive.box<Event>(HiveBoxes.event);
    _initCountries();
    _initCommunities(
      countryId: user.countryId,
      interests: interests,
    );
    _initLatestEvents(countryId: user.countryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    UserData user = userProvider.user!;
    String fullname = user.firstName + " " + user.lastName;
    String imageUrl = user.imageUrl!;

    return Scaffold(
        body: KampongPaddedSafeArea(
      child: KampongFullScreenContainer(
        child: SingleChildScrollView(
          child: Container(
            width: ScreenSize.safeAreaWidth(context) * 0.85,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: KampongColumnStartCenter(
              children: [
                _welcomeHeader(fullname, imageUrl),
                _countrySelector(userProvider),
                _communitiesSlider(),
                _eventsSlider(),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  _initCountries() async {
    List<Country> countries = await SupaCountries.getCountries();
    countries.forEach((Country e) {
      countryBox.put(e.id, e);
    });
  }

  _initCommunities({int? countryId, List<String>? interests}) async {
    List<Community> communities =
        await SupaCommunities.getCommunities(countryId, interests);
    communityBox.deleteAll(communityBox.keys);
    communities.forEach((Community e) {
      communityBox.put(e.id, e);
    });
  }

  _initLatestEvents({int? countryId}) async {
    List<Event> events = await SupaEvents.getLatestEvents(countryId);
    eventBox.deleteAll(eventBox.keys);
    events.forEach((Event e) {
      eventBox.put(e.id, e);
    });
  }

  Widget _welcomeHeader(String name, String imageUrl) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      height: ScreenSize.safeAreaHeight(context) * 0.12,
      child: KampongRowSpaceBetweenCenter(
        children: [
          KampongColumnSpaceAroundStart(
            children: [
              Text(
                "Welcome",
                overflow: TextOverflow.ellipsis,
                style: KampongFonts.header,
              ),
              Text(
                name,
                style: KampongFonts.subHeader,
              )
            ],
          ),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(imageUrl),
          )
        ],
      ),
    );
  }

  Widget _countrySelector(UserProvider userProvider) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Country>(HiveBoxes.countries).listenable(),
      builder: (cxt, Box<Country> countryBox, _) {
        List<Country> countries = countryBox.values.toList();
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: ShapeDecoration(
              color: KampongColors.slab,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              )),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              hint: Text("Where are you from?"),
              value: dropdownValue,
              icon: const Icon(TablerIcons.arrow_down),
              elevation: 20,
              menuMaxHeight: ScreenSize.safeAreaHeight(context) * 0.3,
              style: KampongFonts.countryDropDown,
              dropdownColor: KampongColors.slab,
              items: countries.map((Country e) {
                return DropdownMenuItem(
                  value: e.name,
                  child: Text(e.name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                late final int id;
                for (var i = 0; i < countries.length; i++) {
                  if (countries[i].name == newValue) {
                    id = countries[i].id;
                    break;
                  }
                }
                _initCommunities(countryId: id);
                _initLatestEvents(countryId: id);
                userProvider.changeCountry(
                  newCountryId: id,
                  newCountryName: newValue!,
                );
                setState(() {
                  dropdownValue = newValue;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget _communitiesSlider() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: KampongColumnStartStart(
        children: [
          Text(
            "Communities You Might Be Interested In",
            style: KampongFonts.subHeader,
          ),
          Container(
            height: ScreenSize.safeAreaHeight(context) * 0.3,
            width: ScreenSize.safeAreaWidth(context) * 0.9,
            margin: EdgeInsets.only(top: 5),
            child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<Community>(HiveBoxes.community).listenable(),
              builder: (context, Box<Community> box, _) {
                List<Community> communities = box.values.toList();
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: communities.map(
                    (Community e) {
                      return KampongTile(
                        text: e.name,
                        imageUrl: e.imageUrl,
                        onTap: () {},
                      );
                    },
                  ).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _eventsSlider() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: KampongColumnStartStart(
        children: [
          Text(
            "Upcoming events",
            style: KampongFonts.subHeader,
          ),
          Container(
            height: ScreenSize.safeAreaHeight(context) * 0.3,
            width: ScreenSize.safeAreaWidth(context) * 0.9,
            margin: EdgeInsets.only(top: 5),
            child: ValueListenableBuilder(
              valueListenable: Hive.box<Event>(HiveBoxes.event).listenable(),
              builder: (context, Box<Event> box, _) {
                List<Event> events = box.values.toList();
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: events.map(
                    (Event e) {
                      return KampongTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/event?eventId=${e.id}');
                        },
                        text: e.name,
                        imageUrl: e.imageUrl,
                      );
                    },
                  ).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
