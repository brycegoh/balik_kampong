import 'dart:async';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:balik_kampong/services/supaEvents.dart';
import 'package:balik_kampong/utility/constants.dart';
import 'package:balik_kampong/widgets/layout.dart';
import 'package:flutter/material.dart';

import '../helper/loading.dart';
import '../../models/event.dart';
import '../../provider/user.dart';
import '../../utility/screensize.dart';

class BrowseEventScreen extends StatefulWidget {
  const BrowseEventScreen({Key? key}) : super(key: key);

  @override
  _BrowseEventScreenState createState() => _BrowseEventScreenState();
}

class _BrowseEventScreenState extends State<BrowseEventScreen> {
  late Future _loadEvents;
  Timer? _debounce;

  late List<Event> events;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    if (_debounce != null) {
      _debounce!.cancel();
    }

    super.dispose();
  }

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int countryId = userProvider.user!.countryId;

    _loadEvents = _getAllEvents(countryId);
    super.initState();
  }

  Future _getAllEvents(int countryId) async {
    List<Event> allEvents = await SupaEvents.getAllEvents(countryId: countryId);
    events = allEvents;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int countryId = userProvider.user!.countryId;
    return FutureBuilder(
      future: _loadEvents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: KampongPaddedSafeArea(
                child: KampongFullScreenContainer(
                  child: KampongColumnStartStart(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11.5),
                        child: Text("Events", style: KampongFonts.header),
                      ),
                      Container(
                        height: ScreenSize.safeAreaHeight(context) * 0.05,
                        width: ScreenSize.safeAreaWidth(context) * 1,
                        padding: EdgeInsets.symmetric(vertical: 2),
                        margin:
                            EdgeInsets.symmetric(horizontal: 11.5, vertical: 7),
                        child: KampongRowCenterCenter(
                          children: [
                            Flexible(
                              flex: 5,
                              child: TextField(
                                decoration: InputDecoration(hintText: "Search"),
                                controller: searchController,
                                onChanged: (text) {
                                  if (_debounce?.isActive ?? false) {
                                    _debounce!.cancel();
                                  }
                                  _debounce =
                                      Timer(const Duration(milliseconds: 500),
                                          () async {
                                    List<Event> allEvents =
                                        await SupaEvents.getAllEvents(
                                            countryId: countryId,
                                            search: searchController.text);
                                    setState(() {
                                      events = allEvents;
                                    });
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11.5),
                        child: _scrollingCommunitiesSection(events),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _scrollingCommunitiesSection(List<Event> events) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: events.length,
      itemBuilder: (context, index) {
        return KampongBrowsingEventTile(
          event: events[index],
        );
      },
    );
  }
}

class KampongBrowsingEventTile extends StatefulWidget {
  final bool isClickable;
  final Event event;
  const KampongBrowsingEventTile(
      {Key? key, required this.event, this.isClickable = true})
      : super(key: key);

  @override
  _KampongBrowsingEventTileState createState() =>
      _KampongBrowsingEventTileState();
}

class _KampongBrowsingEventTileState extends State<KampongBrowsingEventTile> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = ScreenSize.safeAreaHeight(context) * 0.27;
    double width = ScreenSize.safeAreaWidth(context) * 1;
    return InkWell(
      onTap: widget.isClickable
          ? () {
              Navigator.pushNamed(context, '/event?eventId=${widget.event.id}');
            }
          : null,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 1,
        ),
        height: height,
        width: width,
        child: KampongColumnStartCenter(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              height: height * 0.65,
              width: width,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                      widget.event.imageUrl,
                    ),
                  )),
            ),
            KampongRowSpaceBetweenCenter(
              children: [
                KampongColumnStartStart(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child:
                          Text(widget.event.name, style: KampongFonts.header),
                    ),
                    Text(widget.event.subheader, style: KampongFonts.subHeader),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: widget.isClickable
                      ? Text(
                          Jiffy(widget.event.dateHappening).format("dd/MM/yy"))
                      : ElevatedButton(
                          onPressed: () {},
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
                              : Text('Join'),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
